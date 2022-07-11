terraform {
  required_providers {
    ssh = {
      source  = "loafoe/ssh"
      version = "1.0.0"
    }
  }
}

data "aws_ami" "ubuntu" {
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

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh
}

resource "local_file" "pem_file" {
  content         = tls_private_key.this.private_key_pem
  filename        = "${var.pem_location}/${var.key_name}/${var.key_name}.pem"
  file_permission = "0600"
}

resource "local_file" "access_shell_script" {
  content         = "ssh -i ./${var.key_name}.pem ubuntu@${module.public_ec2.public_ip[0]}"
  filename        = "${var.pem_location}/${var.key_name}/${var.key_name}.sh"
  file_permission = "0500"
}

resource "local_file" "access_shell_script_to_private" {
  content         = "ssh -i ./${var.key_name}.pem ubuntu@${module.private_ec2.private_ip[0]}"
  filename        = "${var.pem_location}/${var.key_name}/tmp/${var.key_name}-private.sh"
  file_permission = "0400"
}

## https://learn.hashicorp.com/tutorials/terraform/module-use
module "public_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.12.0"

  name           = "public-ec2-${var.key_name}"
  instance_count = 1

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.bastion_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.bastion_security_group_ids
  subnet_id              = var.bastion_public_subnet_id

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = var.volume_size_bastion
    }
  ]

  tags = {
    Name        = "airgap-public-ec2-${var.key_name}"
    Terraform   = "true"
    Environment = "dev"
  }
}

module "private_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.12.0"

  name           = "private-ec2-${var.key_name}"
  instance_count = 1

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.air_gapped_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.air_gapped_security_group_ids
  subnet_id              = var.air_gapped_private_subnet_id

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = var.volume_size_airgap
    }
  ]

  tags = {
    Name        = "airgap-private-ec2-${var.key_name}"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "ssh_resource" "copy_ssh_key" {
  host        = module.public_ec2.public_ip[0]
  user        = "ubuntu"
  private_key = tls_private_key.this.private_key_pem

  depends_on = [module.public_ec2, module.private_ec2]

  file {
    source      = "${var.pem_location}/${var.key_name}/${var.key_name}.pem"
    destination = "/tmp/${var.key_name}.pem"
    permissions = "0600"
  }

  file {
    source      = "${var.pem_location}/${var.key_name}/tmp/${var.key_name}-private.sh"
    destination = "/tmp/${var.key_name}-private.sh"
    permissions = "0700"
  }

  # commands = [
  #   "/tmp/${var.key_name}-private.sh"
  # ]
}

# resource "null_resource" "sync_pem_file" {
#   connection {
#     type        = "ssh"
#     user        = "ubuntu"
#     private_key = file("${var.pem_location}/${var.key_name}/${var.key_name}.pem")
#     host        = module.public_ec2.public_ip[0]
#     agent       = false
#     timeout     = "10s"
#   }

#   provisioner "file" {
#     source      = "${var.pem_location}/${var.key_name}/${var.key_name}.pem"
#     destination = "/tmp/${var.key_name}.pem"
#   }
# }

# resource "null_resource" "sync_access_script_file" {
#   connection {
#     type        = "ssh"
#     user        = "ubuntu"
#     private_key = file("${var.pem_location}/${var.key_name}/${var.key_name}.pem")
#     host        = module.public_ec2.public_ip[0]
#     agent       = false
#     timeout     = "10s"
#   }

#   provisioner "file" {
#     source      = "${var.pem_location}/${var.key_name}/tmp/${var.key_name}-private.sh"
#     destination = "/tmp/${var.key_name}-private.sh"
#   }
# }
