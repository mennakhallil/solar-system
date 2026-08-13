resource "aws_nat_gateway" "aws_nat_gateway_name" {
  allocation_id = var.eip_allocation_id
  subnet_id     = var.subnet_id

  tags = {
    Name = var.nat_gateway_name
  }
}
## nat_gatway used for private subnet to access the internet. It is used in route table for private subnet.
##it needs an elastic ip to be attached to it. It is used in route table for private subnet to access the internet.