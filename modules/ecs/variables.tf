variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "ecs_private_subnets" {
  description = "Private subnets for ECS tasks"
  type        = list(string)
}

variable "cluster_name" {
  description = "ECS Cluster Name"
  type        = string
}

variable "service_name" {
  description = "ECS Service Name"
  type        = string
}

variable "task_cpu" {
  description = "CPU units for the ECS Task"
  type        = string
}

variable "task_memory" {
  description = "Memory for the ECS Task"
  type        = string
}

variable "container_port" {
  description = "Port for the ECS container"
  type        = number
}

variable "execution_role_arn" {
  description = "IAM role ARN for ECS Task Execution"
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN for ECS service"
  type        = string
}

variable "alb_listener_arn" {
  description = "ALB Listener ARN"
  type        = string
}

variable "alb_dns_name" {
  description = "ALB DNS Name"
  type        = string
}

variable "desired_count" {
  description = "Desired count of ECS tasks"
  type        = number
  default     = 1
}

variable "security_group_id" {
  description = "Security group ID for ECS tasks"
  type        = string
}

variable "log_group_name" {
  description = "Log group name for ECS tasks"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "secrets" {
  description = "List of secrets to be passed to ECS tasks"
  type        = list(object({
    name      = string
    valueFrom = string
  }))
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "db_secret_arn" {
  description = "The ARN of the Secrets Manager secret for the database"
  type        = string
}

variable "ecr_image_url_craft" {
  description = "ECR Image URL for the Craft CMS container"
}
