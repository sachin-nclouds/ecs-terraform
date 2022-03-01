locals {
  customer_name = "mclouds-${var.env}"
}

resource "aws_ecr_repository" "aws-ecr" {
  name = "${local.customer_name}-ecr"
  tags = {
    Name        = "${local.customer_name}-ecr"
    Environment = var.env
  }
}