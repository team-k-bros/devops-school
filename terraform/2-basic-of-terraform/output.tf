output "ec2_ip" {
  value       = aws_instance.web.public_ip
  description = "Public EC2 IP"
  # sensitive    = true
}
