# module "vpc2" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "3.12.0"

#   name                  = "vpc2-${var.user}"
#   cidr                  = "192.168.0.0/16"
#   azs                   = ["ap-northeast-2a"]
#   private_subnets       = ["192.168.0.0/24"]
#   public_subnets        = ["192.168.101.0/24"]

#   tags = {
#     Terraform   = "true"
#     Environment = "test"
#   }
# }

# resource "aws_vpc_peering_connection" "vpc_peering" {
#     peer_vpc_id = module.vpc.vpc_id
#     vpc_id      = module.vpc2.vpc_id
#     auto_accept   = true

#     tags = {
#         Terraform = "true"
#         Name = "VPC Peering between ${module.vpc.name} and ${module.vpc2.name}"
#     }
# }