variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}
variable "public_route_table_name" {
  description = "Name of the public route table"
  type        = string
}
variable "internet_gateway_id" {
  description = "ID of the internet gateway"
  type        = string
}
variable "nat_gateway_id" {
  description = "ID of the NAT gateway for private routes"
  type        = string
  default     = ""
}
variable "private_route_table_name" {
  description = "Name of the private route table"
  type        = string
}