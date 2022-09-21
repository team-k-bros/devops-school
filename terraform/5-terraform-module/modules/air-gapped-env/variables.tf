variable "key_name" {
  description = "Value of AWS Region"
  type        = string
}

variable "bastion_security_group_ids" {
  description = "IDs of Security Group for bastion host"
  type        = list(any)
}

variable "air_gapped_security_group_ids" {
  description = "IDs of Security Group for air-gapped host"
  type        = list(any)
}

variable "bastion_public_subnet_id" {
  description = "Public Subnet ID for Bastion host"
  type        = string
}

variable "air_gapped_private_subnet_id" {
  description = "Private Subnet ID for air-gapped host"
  type        = string
}

variable "pem_location" {
  description = "Location for Pem Key File"
  type        = string
}

variable "bastion_instance_type" {
  description = "Instance Type for Bastion Host"
  type        = string
  default     = "t2.medium"
}

variable "air_gapped_instance_type" {
  description = "Instance Type for Air-Gapped Host"
  type        = string
  default     = "t2.medium"
}

variable "volume_size_bastion" {
  description = "EC2 Instance Type"
  type        = number
  default     = 128
}

variable "volume_size_airgap" {
  description = "EC2 Instance Type"
  type        = number
  default     = 128
}
