output "load_balancer_dns" {
  description = "The DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "ecs_cluster_id" {
  value = module.ecs.cluster_id
}

output "aurora_cluster_endpoint" {
  value = module.aurora.aurora_cluster_endpoint
}
