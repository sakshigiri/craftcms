### ECS Module (modules/ecs/main.tf)

resource "aws_ecs_cluster" "craftcms_cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "craftcms_task" {
  family                   = var.service_name
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "craftcms"
      image     = var.ecr_image_url_craft
      "healthCheck": {
        "command": ["CMD-SHELL", "curl -f http://localhost:${var.container_port}/landing.php || exit 1"],
        "interval": 30,
        "timeout": 10,
        "retries": 3,
        "startPeriod": 60
      }
      cpu       = var.task_cpu
      memory    = var.task_memory
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
      environment = [
        { name = "PRIMARY_SITE_URL", value = "http://${var.alb_dns_name}" },
        { name = "APP_ID", value = "CraftCMS" },
        { name = "APP_ENV", value = "dev" },
        { name = "APP_KEY", value = "base64:randomGeneratedKey" },
        { name = "SECURITY_KEY", value = "randomSecurityKey" }
      ]
            secrets = [
        {
            name      = "DB_DRIVER"
            valueFrom = var.db_secret_arn
        },
        {
            name      = "DB_SERVER"
            valueFrom = var.db_secret_arn
        },
        {
            name      = "DB_PORT"
            valueFrom = var.db_secret_arn
        },
        {
            name      = "DB_DATABASE"
            valueFrom = var.db_secret_arn
        },
        {
            name      = "DB_USER"
            valueFrom = var.db_secret_arn
        },
        {
            name      = "DB_PASSWORD"
            valueFrom = var.db_secret_arn
        }
        ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/craftcms"
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "craftcms_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.craftcms_cluster.id
  task_definition = aws_ecs_task_definition.craftcms_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  enable_execute_command = true  # Enable ECS Execute Command
  depends_on = [aws_lb.craftcms_lb, aws_lb_listener.craftcms_listener, aws_lb_target_group.craftcms_target_group]
  network_configuration {
    assign_public_ip = true
    subnets         = aws_subnet.public_subnet[*].id
    security_groups = [aws_security_group.craftcms_sg.id]
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.craftcms_target_group.arn
    container_name   = "craftcms"
    container_port   = var.container_port
  }
}
