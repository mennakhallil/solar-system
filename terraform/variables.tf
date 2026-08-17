variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "solar-system-vpc"
}

variable "subnets" {
  description = "Subnets configuration"

  type = map(object({
    cidr_block        = string
    availability_zone = string
    type              = string
  }))

  default = {
    public-1 = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
      type              = "public"
    }

    private-1 = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1a"
      type              = "private"
    }

    public-2 = {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-east-1b"
      type              = "public"
    }

    private-2 = {
      cidr_block        = "10.0.4.0/24"
      availability_zone = "us-east-1b"
      type              = "private"
    }
  }
}