# resource "aws_instance" "ec2_type_function" {
#   for_each      = toset(var.usernames)
#   ami           = data.aws_ami.ubuntu.id # "ami-0a93a08544874b3b7"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "Terraform-${var.user}-${upper(each.key)}"
#   }
# }
