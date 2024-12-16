output "alb_access_log_bucket_name" {
  description = "S3 bucket name for ALB access logs"
  value       = aws_s3_bucket.alb_access_logs.id
}
