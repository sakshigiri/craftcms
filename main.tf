# VPC Module
module "vpc" {
  source          = "./modules/vpc"
  cidr_block      = var.vpc_cidr_block
  public_subnet_ids = module.subnets.public_subnets
  environment     = var.environment
}

# Subnets Module
module "subnets" {
  source                  = "./modules/subnets"
  vpc_id                  = module.vpc.vpc_id
  vpc_cidr_block          = var.vpc_cidr_block
  public_subnet_count     = var.public_subnet_count
  ecs_private_subnet_count = var.ecs_private_subnet_count
  rds_private_subnet_count = var.rds_private_subnet_count
  environment             = var.environment
}

# Security Groups Module
module "securitygroups" {
  source               = "./modules/securitygroups"
  vpc_id               = module.vpc.vpc_id
  container_port   = var.container_port
  alb_security_group_id = module.alb.alb_security_group_id  
  ecs_security_group_id = module.ecs.security_group_id     
}

# ALB Module
module "alb" {
  source               = "./modules/alb"
  vpc_id               = module.vpc.vpc_id
  private_subnets      = module.subnets.ecs_private_subnets
  lb_security_group_id = module.securitygroups.alb_security_group_id
  access_log_bucket_name = module.lblogs.alb_access_log_bucket_name
}

#Logs Module
module "lblogs" {
  source        = "./modules/lblogs"
  bucket_name   = var.alb_access_log_bucket_name
  aws_account_id = var.aws_account_id
  region        = var.region
  environment   = var.environment
}

# ECS Module
module "ecs" {
  source               = "./modules/ecs"
  vpc_id               = module.vpc.vpc_id
  ecs_private_subnets  = module.subnets.ecs_private_subnets
  cluster_name         = var.cluster_name
  service_name         = var.service_name
  task_cpu             = var.task_cpu
  task_memory          = var.task_memory
  ecr_image_url_craft  = var.ecr_image_url_craft
  container_port       = var.container_port
  execution_role_arn   = module.iam.ecs_task_execution_role_arn
  alb_dns_name         = module.alb.alb_dns_name
  target_group_arn     = module.alb.target_group_arn
  alb_listener_arn     = module.alb.listener_arn
  db_secret_arn        = module.secretsmanager.db_secret_arn
  secrets              = module.secretsmanager.db_secret_arn
  log_group_name       = var.log_group_name
  region               = var.region
  desired_count        = var.desired_count
  security_group_id    = module.securitygroups.ecs_security_group_id
}

# Aurora Module
module "aurora" {
  source                  = "./modules/aurora"
  vpc_id                  = module.vpc.vpc_id
  private_subnets         = module.subnets.rds_private_subnets
  ecs_security_group_ids  = [module.securitygroups.ecs_security_group_id]
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  environment             = var.environment
}

# IAM Module
module "iam" {
  source = "./modules/iam"
  environment = var.environment
}

# Secrets Manager Module
module "secretsmanager" {
  source        = "./modules/secretsmanager"
  environment = var.environment
  db_credentials = {
    DB_DRIVER   = "pgsql"
    DB_SERVER   = module.aurora.aurora_cluster_endpoint
    DB_PORT     = "5432"
    DB_DATABASE = var.database_name
    DB_USER     = var.master_username
    DB_PASSWORD = var.master_password
  }
}

