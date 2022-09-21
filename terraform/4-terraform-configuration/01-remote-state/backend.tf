# terraform {
#   backend "s3" {
#     profile        = "<update-aws-configure-profile>"
#     bucket         = "terraform-s3-bucket-devops-school" # s3 bucket 이름
#     key            = "terraform/terraform.tfstate" # s3 내에서 저장되는 경로
#     region         = "ap-southeast-1" # 원하는 AWS 리전
#     encrypt        = true
#     dynamodb_table = "terraform-lock"
#   }
# }
