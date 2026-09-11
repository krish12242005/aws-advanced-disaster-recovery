resource "aws_db_subnet_group" "main" {
  name = "${var.project_name}-db-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = {
    Name    = "${var.project_name}-db-subnet-group"
    Project = var.project_name
  }
}

resource "aws_db_instance" "main" {
  identifier = "${var.project_name}-database"

  engine         = "postgres"
  engine_version = "16"

  instance_class        = var.instance_class
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp3"

  db_name  = "drdatabase"
  username = var.database_username
  password = var.database_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.database_sg_id]

  multi_az = true

  publicly_accessible     = false
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 7

  backup_window      = "18:00-19:00"
  maintenance_window = "sun:19:00-sun:20:00"

  auto_minor_version_upgrade = true

  enabled_cloudwatch_logs_exports = [
    "postgresql"
  ]

  tags = {
    Name    = "${var.project_name}-database"
    Project = var.project_name
    Tier    = "database"
  }
}
