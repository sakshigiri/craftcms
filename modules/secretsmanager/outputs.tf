output "db_secret_arn" {
  description = "The ARN of the database credentials secret"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "db_secret_name" {
  description = "The name of the database credentials secret"
  value       = aws_secretsmanager_secret.db_credentials.name
}
