locals {
  customer_name = "mClouds-${var.env}"
}

resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = "${local.customer_name}-cluster"
  capacity_providers = ["FARGATE"]
  tags = {
    Name        = "${local.customer_name}-ecs"
    Environment = var.env
  }
}