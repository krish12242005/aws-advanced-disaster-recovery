resource "aws_route53_zone" "main" {
  name = var.domain_name

  tags = {
    Name    = "${var.project_name}-zone"
    Project = var.project_name
    Purpose = "Disaster Recovery DNS"
  }
}

resource "aws_route53_health_check" "primary" {
  fqdn              = var.health_check_domain
  port              = 80
  type              = "HTTP"
  resource_path     = "/health"
  request_interval  = 30
  failure_threshold = 3

  tags = {
    Name    = "${var.project_name}-health-check"
    Project = var.project_name
  }
}

resource "aws_route53_record" "primary" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "app.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }

  set_identifier  = "primary-alb"
  health_check_id = aws_route53_health_check.primary.id

  failover_routing_policy {
    type = "PRIMARY"
  }
}

resource "aws_route53_record" "secondary" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "app.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }

  set_identifier = "secondary-alb"

  failover_routing_policy {
    type = "SECONDARY"
  }
}
