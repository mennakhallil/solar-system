variable "eip_allocation_id" {
  description = "Allocation ID of the Elastic IP for the NAT Gateway"
  type        = string
}
variable "subnet_id" {
  description = "ID of the  public subnet for the NAT Gateway"
  type        = string
}
variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  type        = string
}