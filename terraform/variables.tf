variable "aws_region" {
  description = "AWS region for the disaster recovery architecture"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "cloudnexaa-advanced-dr"
}

variable "domain_name" {
  description = "Route 53 domain name"
  type        = string
  default     = "example.com"
}

variable "health_check_domain" {
  description = "Domain used by Route 53 health check"
  type        = string
  default     = "example.com"
}
