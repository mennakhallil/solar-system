output "elastic_ip" {
  value       = aws_eip.aws_eip_name.public_ip
  description = "The Elastic IP address"
}

output "allocation_id" {
  value       = aws_eip.aws_eip_name.id
  description = "The Elastic IP allocation ID"
}
