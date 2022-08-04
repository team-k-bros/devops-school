data "aws_ami" "ubuntu_virginia" {
  provider = aws.virginia

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# resource "aws_instance" "ec2_multi_provider" {
#   provider = aws.virginia

#   ami           = data.aws_ami.ubuntu_virginia.id # "ami-0a93a08544874b3b7"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "Terraform-multi-provider"
#   }
# }
