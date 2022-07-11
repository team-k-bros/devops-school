# module "ec2_instance" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "3.4.0"

#   name = "instance-${var.user}"

#   ami                    = "ami-020934aa2a26c2c00" # nginx-default
#   instance_type          = "t2.micro"
#   subnet_id              = module.vpc.private_subnets[0]
#   vpc_security_group_ids = [module.vpc.default_security_group_id]

#   tags = {
#     Terraform   = "true"
#     Environment = "test"
#   }
# }