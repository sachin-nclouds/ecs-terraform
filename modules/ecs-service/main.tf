locals {
  customer_name = "mClouds-${var.env}"
}

resource "aws_ecs_service" "aws-ecs-service" {
  name                 = "${local.customer_name}-${var.env}-ecs-service"
  cluster              = var.cluster-id
  task_definition      = "${var.family}:${var.revesion}"
  launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count        = 1
  force_new_deployment = true

  network_configuration {
    subnets          = [var.subnet1_id, var.subnet3_id]
    assign_public_ip = true
    security_groups = [
      var.service-sgid,
      var.sgid
    ]
  }

  load_balancer {
    target_group_arn = var.tgid
    container_name   = "${local.customer_name}-${var.env}-container"
    container_port   = 5000
  }

  depends_on = [var.listenerarn]
}
#data "aws_ecs_task_definition" "main1" {
#  task_definition = var.family
#}

