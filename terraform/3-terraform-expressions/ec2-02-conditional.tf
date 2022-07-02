resource "aws_instance" "ec2_conditional" {
  count         = var.create_ec2 ? 1 : 0
  ami           = data.aws_ami.ubuntu.id # "ami-0a93a08544874b3b7"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-${var.user}-conditional"
  }
}

# output "ec2_conditionaL_ip" {
#   value       = aws_instance.ec2_conditional[0].public_ip
#   description = "Public EC2 IP"
# }
