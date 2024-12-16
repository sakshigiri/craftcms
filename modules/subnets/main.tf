# Create Public Subnets
resource "aws_subnet" "public_subnets" {
  count             = var.public_subnet_count
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, var.subnet_bits, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-public-subnet-${count.index}"
  }
}

# Create Private Subnets for ECS
resource "aws_subnet" "ecs_private_subnets" {
  count             = var.ecs_private_subnet_count
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, var.subnet_bits, count.index + var.public_subnet_count)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "${var.environment}-ecs-private-subnet-${count.index}"
  }
}

# Create Private Subnets for RDS
resource "aws_subnet" "rds_private_subnets" {
  count             = var.rds_private_subnet_count
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, var.subnet_bits, count.index + var.public_subnet_count + var.ecs_private_subnet_count)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "${var.environment}-rds-private-subnet-${count.index}"
  }
}

#NAT Gateway Configurations

# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc = true
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(var.public_subnets, 0)  # NAT Gateway in a public subnet
}

# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.private_subnets)
  subnet_id      = element(var.private_subnets, count.index)
  route_table_id = aws_route_table.private_route_table.id
}

data "aws_availability_zones" "available" {}

