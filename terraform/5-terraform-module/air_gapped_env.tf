locals {
  az_count = 1
  azs = slice(data.aws_availability_zones.available.names, 0, local.az_count)
  private_subnet_ranges = slice(["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"], 0, local.az_count)
  public_subnet_ranges = slice(["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"], 0, local.az_count)
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

resource "aws_security_group" "only_ssh_basiton" {
  name   = "only_ssh_basiton_${var.user}"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "only_ssh_basiton_${var.user}"
  }
}

resource "aws_security_group" "air_gapped" {
  name   = "air_gapped_${var.user}"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = local.public_subnet_ranges
  }

  tags = {
    Name = "air_gapped_${var.user}"
  }
}

module "air_gapped_env" {
  source       = "../modules/air-gapped-env"
  key_name     = "airgapped-installation-${var.user}"
  pem_location = "${path.module}/certs"

  bastion_security_group_ids = [aws_security_group.only_ssh_basiton.id]
  bastion_public_subnet_id   = module.vpc.public_subnets[0]

  air_gapped_security_group_ids = [aws_security_group.air_gapped.id]
  air_gapped_private_subnet_id  = module.vpc.private_subnets[0]
}

output "air_gapped_env_ec2_ips" {
  value = {
    bastion_public_ip       = module.air_gapped_env.public_ec2_public_ip
    bastion_private_ip      = module.air_gapped_env.public_ec2_private_ip
    airgapped_vm_private_ip = module.air_gapped_env.private_ec2_ip
  }
  description = "EC2 IPs: Public -> Private"
}