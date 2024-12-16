variable "environment" {
  description = "Environment for tagging and naming (e.g., dev, prod)"
  type        = string
}

variable "db_credentials" {
  description = "Database credentials to store in Secrets Manager"
  type        = object({
    DB_DRIVER   = string
    DB_SERVER   = string
    DB_PORT     = string
    DB_DATABASE = string
    DB_USER     = string
    DB_PASSWORD = string
  })
}
