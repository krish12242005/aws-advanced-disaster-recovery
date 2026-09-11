output "vpc_id" {
  description = "Disaster recovery VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private application subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS name"
  value       = module.alb.alb_dns_name
}

output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = module.rds.rds_endpoint
}

output "backup_vault_name" {
  description = "AWS Backup vault"
  value       = module.backup.backup_vault_name
}

output "s3_backup_bucket" {
  description = "S3 disaster recovery backup bucket"
  value       = module.s3.bucket_name
}
