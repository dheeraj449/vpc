# create vpc cidr block
variable "vpc_cidr"{
    description = "vpc cidr block"
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet_az1_cidr"{
    description = "public subnet az1 cidr"
    type = string
    default = "10.0.0.0/24"
}

variable "private_subnet_az1_cidr"{
    description = "public subnet az1 cidr"
    type = string
    default = "10.0.1.0/24"
}
