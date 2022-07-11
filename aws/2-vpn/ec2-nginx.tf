# resource "aws_security_group" "vpn_only" {
#   name   = "vpn_only_${var.user}"
#   vpc_id = module.vpc.vpc_id

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["${module.air_gapped_env.public_ec2_public_ip}/32", "${module.air_gapped_env.public_ec2_private_ip}/32"]
#   }

#   tags = {
#     Name = "vpn_only_${var.user}"
#   }
# }

# module "ec2_nginx" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "3.4.0"

#   name = "ec2-for-nginx-${var.user}"

#   ami                    = "ami-020934aa2a26c2c00" # nginx-default
#   instance_type          = "t2.micro"
#   subnet_id              = module.vpc.private_subnets[0]
#   vpc_security_group_ids = [aws_security_group.vpn_only.id]

#   tags = {
#     Terraform   = "true"
#     Environment = "test"
#   }
# }

# output "ec2_nginx_private_ip" {
#   value = module.ec2_nginx.private_ip
# }
