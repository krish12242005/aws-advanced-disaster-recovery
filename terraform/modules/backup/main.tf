resource "aws_backup_vault" "main" {
  name = var.backup_vault_name

  tags = {
    Name    = var.backup_vault_name
    Project = var.project_name
    Purpose = "Disaster Recovery"
  }
}

resource "aws_backup_plan" "main" {
  name = "${var.project_name}-backup-plan"

  rule {
    rule_name         = "${var.project_name}-daily-backup"
    target_vault_name = aws_backup_vault.main.name

    schedule = "cron(0 18 * * ? *)"

    start_window      = 60
    completion_window = 180

    lifecycle {
      delete_after = 35
    }
  }

  tags = {
    Name    = "${var.project_name}-backup-plan"
    Project = var.project_name
  }
}

resource "aws_iam_role" "backup" {
  name = "${var.project_name}-backup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "backup.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name    = "${var.project_name}-backup-role"
    Project = var.project_name
  }
}

resource "aws_iam_role_policy_attachment" "backup" {
  role       = aws_iam_role.backup.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_iam_role_policy_attachment" "restore" {
  role       = aws_iam_role.backup.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

resource "aws_backup_selection" "ec2" {
  name         = "${var.project_name}-ec2-selection"
  iam_role_arn = aws_iam_role.backup.arn
  plan_id      = aws_backup_plan.main.id

  resources = var.ec2_resource_arns
}

resource "aws_backup_selection" "rds" {
  name         = "${var.project_name}-rds-selection"
  iam_role_arn = aws_iam_role.backup.arn
  plan_id      = aws_backup_plan.main.id

  resources = [var.rds_resource_arn]
}
