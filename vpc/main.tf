module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

    name = "${var.app_name}-vpc"
    cidr = var.cidr

    azs             = local.azs
    private_subnets = var.private_subnets
    public_subnets = var.public_subnets

    enable_dns_hostnames = true

    manage_default_network_acl = false

    enable_ipv6 = false

    enable_nat_gateway     = true
    single_nat_gateway     = true
    one_nat_gateway_per_az = false


    private_subnet_tags = {
        Name = "${var.app_name}-private"
    }

    public_subnet_tags = {
        Name = "${var.app_name}-public"
    }

    tags = {
        Owner       = "Terraform"
        Environment = local.env
    }

    vpc_tags = {
        Name = "${var.app_name}-vpc"
    }
}

