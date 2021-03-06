locals {
  customer_name = "mClouds-${var.env}"
}

#data "template_file" "env_vars" {
#  template = file("/home/sachin/abel work/ecs terrform/VPC/modules/ecs-taskdef/env_vars.json")
#}
data "template_file" "env_vars" {
  template = file("env_vars.json")
}

resource "aws_ecs_task_definition" "aws-ecs-task" {
  family = "${local.customer_name}-task"

  container_definitions = <<TASK_DEFINITION
  [
    {
      "name": "${local.customer_name}-${var.env}-container",
      "image": "${var.imageurl}:latest",
      "entryPoint": [],
      "essential": true,
      "environment": [${data.template_file.env_vars.rendered}],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${var.loggroup}",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "${local.customer_name}-${var.env}"
        }
      },
      "portMappings": [
        {
          "containerPort": 5000,
          "hostPort": 5000
        }
      ],
      "cpu": 256,
      "memory": 512,
      "networkMode": "awsvpc"
    }
  ]
  TASK_DEFINITION

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  execution_role_arn       = var.taskrole
  task_role_arn            = var.taskrole

  tags = {
    Name        = "${local.customer_name}-ecs-td"
    Environment = var.env
  }
}

data "aws_ecs_task_definition" "main" {
  task_definition = aws_ecs_task_definition.aws-ecs-task.family
}