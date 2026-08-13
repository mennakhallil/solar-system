resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = var.internet_gateway_id
  }
  tags = {
    Name = var.public_route_table_name
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = var.internet_gateway_id
  }
  tags = {
    Name = var.private_route_table_name
  }
}