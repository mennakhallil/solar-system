resource "aws_internet_gateway" "aws_internet_gateway_name" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.aws_internet_gateway_name
  }
}
## internet gateway used to connect to the internet and allow communication between instances in your VPC and the internet.
## for public subnets, you need to attach an internet gateway to your VPC and configure a route in the route table that points to the internet gateway. This allows instances in the public subnet to access the internet and receive incoming traffic from the internet.