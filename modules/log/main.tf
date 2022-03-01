locals {
  customer_name = "mClouds-${var.env}"
}

resource "aws_cloudwatch_log_group" "log-group" {
  name = "${local.customer_name}-logs"

  tags = {
    Application = local.customer_name
    Environment = var.env
  }
}