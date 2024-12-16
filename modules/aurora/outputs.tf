output "aurora_cluster_endpoint" {
  description = "The endpoint of the Aurora cluster"
  value       = aws_rds_cluster.aurora_postgres_cluster.endpoint
}

output "aurora_reader_endpoint" {
  description = "The reader endpoint of the Aurora cluster"
  value       = aws_rds_cluster.aurora_postgres_cluster.reader_endpoint
}

output "aurora_security_group_id" {
  description = "The security group ID for Aurora"
  value       = aws_security_group.aurora_sg.id
}
