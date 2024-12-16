output "ecs_security_group_id" {
  description = "Security group ID for ECS tasks"
  value       = aws_security_group.ecs_sg.id
}

output "alb_security_group_id" {
  description = "Security group ID for ALB"
  value       = aws_security_group.alb_sg.id
}

output "rds_security_group_id" {
  description = "Security group ID for Aurora RDS"
  value       = aws_security_group.rds_sg.id
}
