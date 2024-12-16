# Secrets Manager for Database Credentials
resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "${var.environment}-db-credentials"
  description = "Database credentials for ${var.environment} environment"

  tags = {
    Name        = "${var.environment}-db-credentials"
    Environment = var.environment
  }
}

# Add Secret Version with DB Credentials
resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode(var.db_credentials)

  depends_on = [aws_secretsmanager_secret.db_credentials]
}

