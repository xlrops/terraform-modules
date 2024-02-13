resource "aws_ssm_parameter" "vpc_id" {
  name  = "/devops/vpc/us-east-1/vpc-id"
  type  = "String"
  value = module.vpc.vpc_id
}


resource "aws_ssm_parameter" "private_subnets_ids" {
  name  = "/devops/vpc/us-east-1/private-subnet-ids"
  type  = "StringList"
  value = join(",", module.vpc.private_subnets)
}

resource "aws_ssm_parameter" "public_subnets_ids" {
  name  = "/devops/vpc/us-east-1/public-subnet-ids"
  type  = "StringList"
  value = join(",", module.vpc.public_subnets)
}
