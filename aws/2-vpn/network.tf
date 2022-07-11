locals {
  az_count              = 1
  azs                   = slice(data.aws_availability_zones.available.names, 0, local.az_count)
  private_subnet_ranges = slice(["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"], 0, local.az_count)
  public_subnet_ranges  = slice(["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"], 0, local.az_count)
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"

  name = "vpc-${var.user}"
  cidr = "10.0.0.0/16"

  azs             = local.azs
  private_subnets = local.private_subnet_ranges
  public_subnets  = local.public_subnet_ranges

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
