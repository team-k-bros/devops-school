# S3 bucket for backend
resource "aws_s3_bucket" "tfstate" {
  bucket = "terraform-s3-bucket-devops-school"
}

# Prevent from deleting tfstate file
resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}
