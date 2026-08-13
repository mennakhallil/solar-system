output "subnet_ids" {
  value = aws_subnet.aws_subnet_name[*].id
}