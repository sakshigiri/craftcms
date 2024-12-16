output "public_subnets" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public_subnets[*].id
}

output "ecs_private_subnets" {
  description = "IDs of the private subnets for ECS"
  value       = aws_subnet.ecs_private_subnets[*].id
}

output "rds_private_subnets" {
  description = "IDs of the private subnets for RDS"
  value       = aws_subnet.rds_private_subnets[*].id
}
