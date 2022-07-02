# S3 bucket for backend
resource "aws_s3_bucket" "tfstate" {
  bucket = "terraform-s3-bucket-devops-school"

  versioning {
    enabled = true # Prevent from deleting tfstate file
  }
}