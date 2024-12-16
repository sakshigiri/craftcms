output "cluster_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.craftcms_cluster.id
}
output "security_group_id" {
  description = "The security group ID for ECS tasks"
  value       = aws_security_group.ecs_sg.id
}
