output "instance_ids" {
  value = aws_instance.app[*].id
}

output "instance_arns" {
  value = aws_instance.app[*].arn
}

output "private_ip_addresses" {
  value = aws_instance.app[*].private_ip
}
