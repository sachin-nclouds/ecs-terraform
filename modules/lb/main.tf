
#resource "aws_lb" "mcloud-lb" {
#  name               = "mclouds-lb"
#  internal           = false
#  load_balancer_type = "network"
#  subnets            = [var.subnet1_id, var.subnet2_id]
#  enable_deletion_protection = true
#
#  tags = {
#    Environment = "production"
#  }
#}
locals {
  customer_name = "mClouds-${var.env}"
}
resource "aws_alb" "application_load_balancer" {
  name               = "${local.customer_name}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.subnet1_id, var.subnet3_id]
  security_groups    = [var.alb-sg]

  tags = {
    Name        = "${local.customer_name}-alb"
    Environment = var.env
  }
}




resource "aws_lb_target_group" "target_group" {
  name        = "${local.customer_name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id1

  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${local.customer_name}-lb-tg"
    Environment = var.env
  }
}
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.id
  }
}