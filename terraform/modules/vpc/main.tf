resource "aws_vpc" "aws_vpc_name" {
    cidr_block       = var.vpc_cidr_block
    enable_dns_support   = true
    enable_dns_hostnames = true


  tags = {
    Name = var.vpc_name
  }
}
