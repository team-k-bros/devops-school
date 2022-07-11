# resource "aws_security_group" "vpn" {
#   name   = "vpn_${var.user}"
#   vpc_id = module.vpc.vpc_id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 1194
#     to_port     = 1194
#     protocol    = "udp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "vpn_${var.user}"
#   }
# }

# resource "aws_security_group" "air_gapped" {
#   name   = "air_gapped_${var.user}"
#   vpc_id = module.vpc.vpc_id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = local.public_subnet_ranges
#   }

#   tags = {
#     Name = "air_gapped_${var.user}"
#   }
# }

# module "air_gapped_env" {
#   source       = "../modules/air-gapped-env"
#   key_name     = "airgapped-installation-${var.user}"
#   pem_location = "${path.module}/certs"

#   bastion_security_group_ids = [aws_security_group.vpn.id]
#   bastion_public_subnet_id   = module.vpc.public_subnets[0]
#   bastion_instance_type      = "t2.small"

#   air_gapped_security_group_ids = [aws_security_group.air_gapped.id]
#   air_gapped_private_subnet_id  = module.vpc.private_subnets[0]
#   air_gapped_instance_type      = "t2.micro"
# }

# output "air_gapped_env_ec2_ips" {
#   value = {
#     bastion_public_ip       = module.air_gapped_env.public_ec2_public_ip
#     bastion_private_ip      = module.air_gapped_env.public_ec2_private_ip
#     airgapped_vm_private_ip = module.air_gapped_env.private_ec2_ip
#   }
#   description = "EC2 IPs: Public -> Private"
# }
