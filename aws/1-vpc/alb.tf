# module "alb" {
#   source  = "terraform-aws-modules/alb/aws"
#   version = "6.4.0"

#   name            = "alb-${var.user}"
#   vpc_id          = module.vpc.vpc_id
#   subnets         = module.vpc.public_subnets
#   security_groups = [module.vpc.default_security_group_id, module.web_server_sg.security_group_id]

#   target_groups   = [
#     {
#       name             = "target-group-${var.user}"
#       backend_protocol = "HTTP"
#       backend_port     = 80
#       target_type      = "instance"
#       targets = [
#         {
#           target_id    = module.ec2_instance.id
#           port         = 80
#         }
#       ]
#     }
#   ]

#   http_tcp_listeners = [
#     {
#       port = 80
#       protocol = "HTTP"
#     }
#   ]

#   tags = {
#     Terraform   = "true"
#     Environment = "test"
#   }
# }

# module "web_server_sg" {
#   source = "terraform-aws-modules/security-group/aws//modules/http-80"

#   name        = "security-group-${var.user}"
#   vpc_id      = module.vpc.vpc_id

#   ingress_cidr_blocks = ["0.0.0.0/0"]

#   tags = {
#     Terraform   = "true"
#     Environment = "test"
#     Name        = "sg-${var.user}"
#   }
# }