# terraform import aws_instance.ec2_import i-12345678
# terraform state rm aws_instance.ec2_import
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "ec2_import" {
  ami           = "<update-ami>"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-import"
  }
}
