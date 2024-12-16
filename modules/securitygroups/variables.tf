variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "container_port" {
  description = "Port for ECS container traffic"
  type        = number
  default     = 80
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "ecs_security_group_id" {
  description = "Security group ID for ECS tasks"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security group ID for the ALB"
  type        = string
}
