resource "aws_instance" "ec2_module" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "ec2-module-${var.name}"
  }
}
