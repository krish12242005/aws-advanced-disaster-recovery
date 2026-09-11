terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  aws_region   = var.aws_region
}

module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
}

module "alb" {
  source = "./modules/alb"

  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.vpc.alb_security_group_id
}

module "ec2" {
  source = "./modules/ec2"

  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  application_sg_id     = module.vpc.application_security_group_id
  target_group_arn      = module.alb.target_group_arn
  instance_profile_name = module.iam.ec2_instance_profile_name
}

module "rds" {
  source = "./modules/rds"

  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  database_sg_id     = module.vpc.database_security_group_id
}

module "s3" {
  source = "./modules/s3"

  project_name = var.project_name
}

module "backup" {
  source = "./modules/backup"

  project_name      = var.project_name
  backup_vault_name = "${var.project_name}-vault"
  ec2_resource_arns = module.ec2.instance_arns
  rds_resource_arn  = module.rds.rds_arn
}

module "route53" {
  source = "./modules/route53"

  project_name        = var.project_name
  alb_dns_name        = module.alb.alb_dns_name
  alb_zone_id         = module.alb.alb_zone_id
  domain_name         = var.domain_name
  health_check_domain = var.health_check_domain
}


