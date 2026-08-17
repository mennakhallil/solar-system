resource "aws_eip" "aws_eip_name" {
  domain = "vpc"
  tags = {
    Name = var.aws_eip_name
  }
}
