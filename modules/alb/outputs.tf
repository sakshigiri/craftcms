output "alb_arn" {
  value = aws_lb.craftcms_lb.arn
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.craftcms_lb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.craftcms_target_group.arn
}

output "listener_arn" {
  value = aws_lb_listener.craftcms_listener.arn
}