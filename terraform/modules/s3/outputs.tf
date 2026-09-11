output "bucket_name" {
  description = "S3 disaster recovery backup bucket name"
  value       = aws_s3_bucket.backup.bucket
}

output "bucket_arn" {
  description = "S3 disaster recovery backup bucket ARN"
  value       = aws_s3_bucket.backup.arn
}
