# S3 Bucket for ALB Access Logs
resource "aws_s3_bucket" "alb_access_logs" {
  bucket        = var.bucket_name
  acl           = "log-delivery-write"  # Ensures ALB can write logs to the bucket

  # Enable server-side encryption for security
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "${var.environment}-alb-access-logs"
    Environment = var.environment
  }
}

# Bucket Policy to Allow ALB to Write Logs
resource "aws_s3_bucket_policy" "alb_access_logs_policy" {
  bucket = aws_s3_bucket.alb_access_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowALBAccessLogging",
        Effect    = "Allow",
        Principal = {
          Service = "logdelivery.elasticloadbalancing.amazonaws.com"
        },
        Action    = "s3:PutObject",
        Resource  = "${aws_s3_bucket.alb_access_logs.arn}/*",
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = var.aws_account_id
          },
          ArnLike = {
            "aws:SourceArn" = "arn:aws:elasticloadbalancing:${var.region}:${var.aws_account_id}:loadbalancer/app/*"
          }
        }
      }
    ]
  })
}

