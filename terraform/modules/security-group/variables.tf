variable "aws_security_group_name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "ingress_cidr_blocks" {
  description = "CIDR blocks allowed to access the application"
  type        = list(string)
}

variable "egress_cidr_blocks" {
  description = "CIDR blocks allowed for outbound traffic"
  type        = list(string)
}