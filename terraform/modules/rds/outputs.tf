output "rds_endpoint" {
  value = aws_db_instance.main.endpoint
}

output "rds_address" {
  value = aws_db_instance.main.address
}

output "rds_port" {
  value = aws_db_instance.main.port
}

output "rds_identifier" {
  value = aws_db_instance.main.identifier
}

output "rds_arn" {
  value = aws_db_instance.main.arn
}
