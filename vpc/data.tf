data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

data "aws_ssm_parameter" "private_subnets" {
  name = "/devops/vpc/us-east-1/private-subnets"
}

data "aws_ssm_parameter" "public_subnets" {
  name = "/devops/vpc/us-east-1/public-subnets"
}

data "aws_ssm_parameter" "vpc_cidr" {
  name = "/devops/vpc/us-east-1/vpc-cidr"
}