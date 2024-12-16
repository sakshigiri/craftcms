# Global Variables
variable "region" {
  description = "AWS region"
  type        = string
  default     = "ca-central-1"
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

# VPC and Subnet Variables

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
  default     = 2
}

variable "ecs_private_subnet_count" {
  description = "Number of private subnets for ECS"
  type        = number
  default     = 2
}

variable "rds_private_subnet_count" {
  description = "Number of private subnets for RDS"
  type        = number
  default     = 2
}

# ECS Variables
variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "ecs-cluster"
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
  default     = "ecs-service"
}

variable "task_cpu" {
  description = "CPU units for the ECS task"
  type        = string
  default     = "256"
}

variable "task_memory" {
  description = "Memory for the ECS task in MiB"
  type        = string
  default     = "512"
}

variable "container_port" {
  description = "Port for the ECS container"
  type        = number
  default     = 8080
}

variable "log_group_name" {
  description = "Name of the CloudWatch log group for ECS"
  type        = string
  default     = "/ecs/ecs-service"
}

variable "desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 1
}

# ALB Variables
variable "alb_access_log_bucket_name" {
  description = "Name of the S3 bucket for ALB access logs"
  type        = string
  default     = "my-alb-access-logs-bucket"
}

# Aurora Variables
variable "database_name" {
  description = "Aurora database name"
  type        = string
  default     = "craftcms_db"
}

variable "master_username" {
  description = "Aurora master username"
  type        = string
  default     = "craftcmspoc"
}

variable "master_password" {
  description = "Aurora master password"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "ecr_image_url_craft" {
  description = "ECR Image URL for the Craft CMS container"
  default     = "864899849560.dkr.ecr.ca-central-1.amazonaws.com/craftcms:nginx8.2"
}
