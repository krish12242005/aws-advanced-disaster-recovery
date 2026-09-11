resource "aws_instance" "app" {
  count = length(var.private_subnet_ids)

  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [var.application_sg_id]

  iam_instance_profile = var.instance_profile_name

  user_data = <<-EOF
              #!/bin/bash
              set -e

              dnf update -y
              dnf install -y httpd

              systemctl enable httpd
              systemctl start httpd

              mkdir -p /var/www/html

              cat > /var/www/html/index.html <<'HTML'
              <!DOCTYPE html>
              <html>
              <head>
                <title>Cloudnexaa Disaster Recovery</title>
              </head>
              <body>
                <h1>Disaster Recovery Application</h1>
                <p>Multi-AZ application server is running.</p>
              </body>
              </html>
              HTML

              cat > /var/www/html/health <<'HTML'
              OK
              HTML

              chown -R apache:apache /var/www/html
              EOF

  tags = {
    Name    = "${var.project_name}-app-${count.index + 1}"
    Project = var.project_name
    Tier    = "application"
  }
}

resource "aws_lb_target_group_attachment" "app" {
  count = length(aws_instance.app)

  target_group_arn = var.target_group_arn
  target_id        = aws_instance.app[count.index].id
  port             = 80
}
