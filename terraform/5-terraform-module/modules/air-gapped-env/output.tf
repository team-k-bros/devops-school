output "public_ec2_public_ip" {
  value       = module.public_ec2.public_ip[0]
  description = "Public IP of Public EC2"
}

output "public_ec2_private_ip" {
  value       = module.public_ec2.private_ip[0]
  description = "Private IP of Public EC2"
}

output "private_ec2_ip" {
  value       = module.private_ec2.private_ip[0]
  description = "Private EC2 IP"
}

output "tls_private_key_pem" {
  value = tls_private_key.this.private_key_pem
}