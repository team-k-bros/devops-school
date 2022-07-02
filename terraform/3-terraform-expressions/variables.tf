variable "aws_region" {
  description = "Value of AWS Region"
  type        = string
}

variable "aws_access_key" {
  description = "Value of AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "Value of AWS Access Key"
  type        = string
}

variable "create_ec2" {
  description = "choose to create an ec2"
  type        = bool
}

variable "user" {
  description = "user name"
  type        = string
}
# list
variable "usernames" {
  description = "user names"
  type        = list(string)
  default     = ["marco", "jake"]
}
# map
variable "user_details" {
  description = "user details"
  type        = map(any)
  default = {
    name     = "marco"
    location = "Singapore"
  }
}
