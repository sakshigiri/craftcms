# Security Group for ECS Tasks
resource "aws_security_group" "ecs_sg" {
  name        = "ecs-task-sg"
  vpc_id      = var.vpc_id
  description = "Security group for ECS tasks"

  # Allow traffic from ALB to ECS
  ingress {
    from_port   = var.ecs_container_port
    to_port     = var.ecs_container_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Allow traffic from the ALB security group
resource "aws_security_group_rule" "ecs_inbound_from_alb" {
  type                     = "ingress"
  from_port                = var.container_port
  to_port                  = var.container_port
  protocol                 = "tcp"
  security_group_id        = var.ecs_security_group_id
  source_security_group_id = var.alb_security_group_id
}

# Security Group for Load Balancer
resource "aws_security_group" "alb_sg" {
  name        = "alb-private-sg"
  vpc_id      = var.vpc_id
  description = "Security group for ALB"

  # Allow HTTP traffic from any IP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS traffic (if needed)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-alb-sg"
  }
}

# Security Group for Aurora RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  vpc_id      = var.vpc_id
  description = "Security group for Aurora RDS"

  # Allow access from ECS tasks
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
