locals {
    env    = terraform.workspace
    account_id  = data.aws_caller_identity.current.account_id
    region      = data.aws_region.current.name
    azs = slice(data.aws_availability_zones.available.names, 0, 3)
    name_prefix = var.app_name

    tags = {
        team     = "devops"
        solution = "${var.app_name}-${local.env}"
    }
}