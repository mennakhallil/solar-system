######################################
# VPC
######################################

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block = var.vpc_cidr_block
  vpc_name       = var.vpc_name
}


######################################
# SUBNETS
######################################

module "subnets" {
  source = "./modules/subnets"

  vpc_id            = module.vpc.vpc_id
  subnet_cidr_block = [for subnet in var.subnets : subnet.cidr_block]
  subnet_names      = [for name, subnet in var.subnets : "solar-${name}"]
  availability_zone = [for subnet in var.subnets : subnet.availability_zone]
  public_subnets    = [for subnet in var.subnets : lookup(subnet, "public", false)]
}


######################################
# INTERNET GATEWAY
######################################

module "internet_gateway" {
  source = "./modules/internet-gatway"

  vpc_id = module.vpc.vpc_id

  aws_internet_gateway_name = "solar-internet-gateway"
}


######################################
# ELASTIC IP
######################################

module "elastic_ip" {
  source = "./modules/elastic-ip"

  count = 2

  aws_eip_name = "solar-eip-${count.index + 1}"
}


######################################
# NAT GATEWAY
######################################

module "nat_gateway" {
  source = "./modules/nat-gatway"

  count = 2

  eip_allocation_id = module.elastic_ip[count.index].allocation_id

  subnet_id = module.subnets.subnet_ids[count.index]

  nat_gateway_name = "solar-nat-${count.index + 1}"
}

######################################
# PUBLIC ROUTE TABLE
######################################

module "public_route_table" {
  source                   = "./modules/route-table"
  count                    = 2
  vpc_id                   = module.vpc.vpc_id
  public_route_table_name  = "solar-public-route-table-${count.index + 1}"
  internet_gateway_id      = module.internet_gateway.aws_internet_gateway_name_id
  private_route_table_name = "solar-private-route-table-${count.index + 1}"
}


######################################
# PRIVATE ROUTE TABLE
######################################

module "private_route_table" {
  source = "./modules/route-table"

  count = 2

  vpc_id                   = module.vpc.vpc_id
  public_route_table_name  = "solar-public-route-table-${count.index + 1}"
  internet_gateway_id      = module.internet_gateway.aws_internet_gateway_name_id
  nat_gateway_id           = module.nat_gateway[count.index].nat_gateway_id
  private_route_table_name = "solar-private-route-table-${count.index + 1}"
}


######################################
# SECURITY GROUP
######################################

module "security_group" {
  source = "./modules/security-group"

  aws_security_group_name = "solar-security-group"
  description             = "Solar Security Group"
  vpc_id                  = module.vpc.vpc_id

  ingress_cidr_blocks = [
    "0.0.0.0/0"
  ]

  egress_cidr_blocks = [
    "0.0.0.0/0"
  ]
}