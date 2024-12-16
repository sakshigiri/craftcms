variable "vpc_id" {
  description = "VPC ID where the ALB will be deployed"
  type        = string
}

variable "lb_security_group_id" {
  description = "Security group ID for the ALB"
  type        = string
}

variable "access_log_bucket_name" {
  description = "S3 bucket name for ALB access logs"
  type        = string
}

variable "access_log_prefix" {
  description = "S3 prefix for ALB access logs"
  type        = string
  default     = "alb-logs"
}

variable "access_logging_enabled" {
  description = "Enable access logging for ALB"
  type        = bool
  default     = true
}

variable "target_port" {
  description = "Port on the target group"
  type        = number
  default     = 80
}

variable "target_protocol" {
  description = "Protocol for the target group"
  type        = string
  default     = "HTTP"
}

variable "listener_port" {
  description = "Listener port for the ALB"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "Listener protocol for the ALB"
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  description = "Path for ALB health check"
  type        = string
  default     = "/landing.php"
}

variable "health_check_protocol" {
  description = "Protocol for ALB health check"
  type        = string
  default     = "HTTP"
}

variable "health_check_interval" {
  description = "Interval for ALB health check (seconds)"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Timeout for ALB health check (seconds)"
  type        = number
  default     = 10
}

variable "healthy_threshold" {
  description = "Healthy threshold for ALB health check"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "Unhealthy threshold for ALB health check"
  type        = number
  default     = 2
}

variable "private_subnets" {
  description = "Private subnets for ALB placement"
  type        = list(string)
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}
