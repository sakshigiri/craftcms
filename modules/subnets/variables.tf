variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  type        = string
}

variable "subnet_bits" {
  description = "Number of additional subnet bits"
  type        = number
  default     = 8
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
  default     = 2
}

variable "ecs_private_subnet_count" {
  description = "Number of ECS private subnets"
  type        = number
  default     = 2
}

variable "rds_private_subnet_count" {
  description = "Number of RDS private subnets"
  type        = number
  default     = 2
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
}
