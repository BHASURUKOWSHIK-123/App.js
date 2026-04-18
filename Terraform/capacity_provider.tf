resource "aws_ecs_capacity_provider" "main" {
  name = "${var.suffix}-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.main.arn

    managed_scaling {
      status = "ENABLED"
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "attach" {
  cluster_name       = aws_ecs_cluster.main.name
  capacity_providers = [aws_ecs_capacity_provider.main.name]
}