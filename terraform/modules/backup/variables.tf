variable "project_name" {
  type = string
}

variable "backup_vault_name" {
  type = string
}

variable "ec2_resource_arns" {
  description = "EC2 resources protected by AWS Backup"
  type        = list(string)
}

variable "rds_resource_arn" {
  description = "RDS resource protected by AWS Backup"
  type        = string
}
