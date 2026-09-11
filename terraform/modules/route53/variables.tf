variable "project_name" {
  type = string
}

variable "domain_name" {
  description = "Route 53 hosted zone domain"
  type        = string
}

variable "health_check_domain" {
  description = "Domain monitored by Route 53 health check"
  type        = string
}

variable "alb_dns_name" {
  type = string
}

variable "alb_zone_id" {
  type = string
}
