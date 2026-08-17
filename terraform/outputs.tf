output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}


output "subnet_ids" {
  description = "All subnet IDs"
  value       = module.subnets.subnet_ids
}


output "security_group_id" {
  description = "Security Group ID"
  value       = module.security_group.security_group_id
}


output "nat_gateway_ids" {
  description = "NAT Gateway IDs"

  value = {
    nat-1 = module.nat_gateway[0].nat_gateway_id
  }
}


output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = module.internet_gateway.aws_internet_gateway_name_id
}

output "public_route_table_ids" {
  description = "Public route table IDs"
  value = {
    public-1 = module.public_route_table[0].public_route_table_id
    public-2 = module.public_route_table[1].public_route_table_id
  }
}

output "private_route_table_ids" {
  description = "Private route table IDs"
  value = {
    private-1 = module.private_route_table[0].private_route_table_id
  }
}