module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.12.0"

  name                  = "vpc-${var.user}"
  cidr                  = "10.0.0.0/16"
  secondary_cidr_blocks = ["10.1.0.0/16", "10.2.0.0/16", "10.3.0.0/16"]
  azs                   = ["ap-northeast-2a", "ap-northeast-2c"]
  private_subnets       = ["10.1.0.0/16", "10.3.0.0/16"]
  public_subnets        = ["10.0.101.0/24", "10.0.103.0/24"]
  enable_nat_gateway    = true
  single_nat_gateway    = true

  tags = {
    Terraform   = "true"
    Environment = "test"
  }
}