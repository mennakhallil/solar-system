#!/bin/bash
    set -e

    REGION="us-east-1"

    # Delete NAT Gateways
    for nat in $(aws ec2 describe-nat-gateways \
      --region $REGION \
      --query 'NatGateways[?State!=`deleted`].NatGatewayId' \
      --output text); do

      echo "Deleting NAT Gateway: $nat"
      aws ec2 delete-nat-gateway \
        --nat-gateway-id "$nat" \
        --region $REGION
    done

    # Wait for NAT Gateways to disappear
    while aws ec2 describe-nat-gateways \
      --region $REGION \
      --query 'NatGateways[?State!=`deleted`].NatGatewayId' \
      --output text | grep -q 'nat-'; do

      echo "Waiting for NAT Gateways..."
      sleep 10
    done

    # Delete non-default VPCs
    for vpc in $(aws ec2 describe-vpcs \
      --region $REGION \
      --query 'Vpcs[?IsDefault==`false`].VpcId' \
      --output text); do

      echo "Cleaning VPC: $vpc"

      # Delete Internet Gateways
      for igw in $(aws ec2 describe-internet-gateways \
        --region $REGION \
        --filters Name=attachment.vpc-id,Values=$vpc \
        --query 'InternetGateways[].InternetGatewayId' \
        --output text); do

        aws ec2 detach-internet-gateway \
          --internet-gateway-id "$igw" \
          --vpc-id "$vpc" \
          --region $REGION || true

        aws ec2 delete-internet-gateway \
          --internet-gateway-id "$igw" \
          --region $REGION || true
      done

      # Delete subnets
      for subnet in $(aws ec2 describe-subnets \
        --region $REGION \
        --filters Name=vpc-id,Values=$vpc \
        --query 'Subnets[].SubnetId' \
        --output text); do

        aws ec2 delete-subnet \
          --subnet-id "$subnet" \
          --region $REGION || true
      done

      # Delete non-main route tables
      for rt in $(aws ec2 describe-route-tables \
        --region $REGION \
        --filters Name=vpc-id,Values=$vpc \
        --query 'RouteTables[?Associations[?Main!=`true`]].RouteTableId' \
        --output text); do

        aws ec2 delete-route-table \
          --route-table-id "$rt" \
          --region $REGION || true
      done

      # Delete VPC
      echo "Deleting VPC: $vpc"
      aws ec2 delete-vpc \
        --vpc-id "$vpc" \
        --region $REGION || true
    done

    # Release all unassociated Elastic IPs
    for allocation in $(aws ec2 describe-addresses \
      --region $REGION \
      --query 'Addresses[?AssociationId==null].AllocationId' \
      --output text); do

      echo "Releasing EIP: $allocation"

      aws ec2 release-address \
        --allocation-id "$allocation" \
        --region $REGION
    done