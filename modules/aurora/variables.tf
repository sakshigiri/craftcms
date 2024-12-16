variable "vpc_id" {
  description = "The VPC ID where Aurora will be deployed"
  type        = string
}

variable "private_subnets" {
  description = "Private subnets for Aurora"
  type        = list(string)
}

variable "ecs_security_group_ids" {
  description = "Security group IDs for ECS tasks that need to access Aurora"
  type        = list(string)
}

variable "engine_version" {
  description = "Aurora PostgreSQL engine version"
  type        = string
  default     = "16.3"
}

variable "database_name" {
  description = "Name of the Aurora database"
  type        = string
  default     = "craftcms_db"
}

variable "master_username" {
  description = "Master username for the Aurora database"
  type        = string
  default     = "craftcmspoc"
}

variable "master_password" {
  description = "Master password for the Aurora database"
  type        = string
}

variable "instance_count" {
  description = "Number of Aurora cluster instances"
  type        = number
  default     = 1
}

variable "instance_class" {
  description = "Instance class for Aurora cluster instances"
  type        = string
  default     = "db.r5.large"
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on deletion"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environment for tagging (e.g., dev, prod)"
  type        = string
}
