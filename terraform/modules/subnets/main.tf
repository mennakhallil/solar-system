
resource "aws_subnet" "aws_subnet_name" {
  count             = length(var.subnet_cidr_block)
  availability_zone = var.availability_zone[count.index]
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block[count.index]

  tags = {
    Name = "${var.subnet_names[count.index]}"
  }
}

