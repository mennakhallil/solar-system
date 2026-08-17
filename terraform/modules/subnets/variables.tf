variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_cidr_block" {
  description = "CIDR blocks for the subnets"
  type        = list(string)
}

variable "availability_zone" {
  description = "Availability zones for the subnets"
  type        = list(string)
}

variable "subnet_names" {
  description = "Names of the subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "Whether each subnet is public"
  type        = list(bool)
}
