variable "bucket_name" {
  description = "Name of the S3 bucket for ALB access logs"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Environment for tagging (e.g., dev, prod)"
  type        = string
}
