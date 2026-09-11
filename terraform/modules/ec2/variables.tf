variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "application_sg_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "instance_profile_name" {
  type = string
}

variable "ami_id" {
  description = "Amazon Linux 2023 AMI"
  type        = string
  default     = "ami-03f4878755434977f"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}
