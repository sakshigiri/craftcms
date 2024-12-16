resource "aws_lb" "craftcms_lb" {
  name               = "craftcms-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.lb_security_group_id]
  subnets            = var.private_subnets

  access_logs {
    bucket  = var.access_log_bucket_name
    prefix  = var.access_log_prefix
    enabled = var.access_logging_enabled
  }

  tags = {
    Name        = "${var.environment}-craftcms-lb"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "craftcms_target_group" {
  name       = "craftcms-tg"
  port       = var.target_port
  protocol   = var.target_protocol
  vpc_id     = var.vpc_id
  target_type = "ip"

  health_check {
    path                = var.health_check_path
    protocol            = var.health_check_protocol
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }
}

resource "aws_lb_listener" "craftcms_listener" {
  load_balancer_arn = aws_lb.craftcms_lb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.craftcms_target_group.arn
  }
}


