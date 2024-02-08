variable app_name {
    default = "jenkins"
}

variable cidr {
    default = "10.25.0.0/16"
}

variable "private_subnets" {
    type    = list(any)
    default = ["10.25.1.0/24", "10.25.2.0/24", "10.25.3.0/24"]
}

variable "public_subnets" {
    type    = list(any)
    default = ["10.25.101.0/24", "10.25.102.0/24", "10.25.103.0/24"]
}
