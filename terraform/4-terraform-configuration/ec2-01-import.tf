# terraform import aws_instance.ec2_import i-12345678
# terraform state rm aws_instance.ec2_import
resource "aws_instance" "ec2_import" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-${var.user}-import"
  }
}
