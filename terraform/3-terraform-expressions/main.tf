# provider "aws" {
#   access_key = "<AWS_ACCESS_KEY>"
#   secret_key = "<AWS_SECRET_KEY>"
#   region     = "ap-northeast-2"
# }

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}