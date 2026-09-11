output "backup_vault_name" {
  description = "AWS Backup vault name"
  value       = aws_backup_vault.main.name
}

output "backup_vault_arn" {
  description = "AWS Backup vault ARN"
  value       = aws_backup_vault.main.arn
}

output "backup_plan_id" {
  description = "AWS Backup plan ID"
  value       = aws_backup_plan.main.id
}

output "backup_role_arn" {
  description = "IAM role used by AWS Backup"
  value       = aws_iam_role.backup.arn
}
