# Aurora Subnet Group
resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "${var.environment}-aurora-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "${var.environment}-aurora-subnet-group"
  }
}

# Security Group for Aurora
resource "aws_security_group" "aurora_sg" {
  name        = "${var.environment}-aurora-sg"
  description = "Security group for Aurora PostgreSQL"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = var.ecs_security_group_ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Aurora RDS Cluster
resource "aws_rds_cluster" "aurora_postgres_cluster" {
  cluster_identifier      = "${var.environment}-aurora-cluster"
  engine                  = "aurora-postgresql"
  engine_version          = var.engine_version
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  vpc_security_group_ids  = [aws_security_group.aurora_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name
  skip_final_snapshot     = var.skip_final_snapshot
  storage_encrypted       = true

  tags = {
    Name = "${var.environment}-aurora-cluster"
  }
}

# Aurora RDS Cluster Instances
resource "aws_rds_cluster_instance" "aurora_instance" {
  count             = var.instance_count
  identifier        = "${var.environment}-aurora-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora_postgres_cluster.id
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.aurora_postgres_cluster.engine
  publicly_accessible = false

  tags = {
    Name = "${var.environment}-aurora-instance-${count.index}"
  }
}

