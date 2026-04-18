resource "aws_ecs_cluster" "main" {
  name = "${var.suffix}-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "nginx" {
  family                   = "nginx"
  requires_compatibilities = ["EC2"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512

  execution_role_arn = aws_iam_role.ecs_execution.arn
  task_role_arn      = aws_iam_role.task_role.arn

  container_definitions = jsonencode([
    {
      name  = "nginx",
      image = "nginx:latest",
      portMappings = [{ containerPort = 80 }],
      secrets = [{
        name      = "${var.suffix}-MY_SECRET",
        valueFrom = var.ssm_param_arn
      }]
    }
  ])
}

resource "aws_ecs_service" "svc" {
  name            = "${var.suffix}-nginx-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = 2

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.main.name
    weight            = 1
    base              = 1
  }

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = "nginx"
    container_port   = 80
  }
}