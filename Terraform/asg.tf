data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

resource "aws_launch_template" "ecs" {
  name_prefix            = "${var.suffix}-ecs-template"
  image_id               = data.aws_ssm_parameter.ecs_ami.value
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ecs_sg.id]

  metadata_options {
    http_tokens = "required"
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.ecs_instance_profile.arn
  }

  user_data = base64encode(<<-EOF
  #!/bin/bash
  echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.suffix}-ecs-instance"
    }
  }
}

resource "aws_autoscaling_group" "main" {
  name                   = "${var.suffix}-asg"
  desired_capacity       = var.desired_capacity
  max_size               = var.max_capacity
  min_size               = var.min_capacity
  vpc_zone_identifier    = var.private_subnets
  target_group_arns      = [aws_lb_target_group.tg.arn]
  health_check_type      = "ELB"
  health_check_grace_period = 300

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = 1
      on_demand_percentage_above_base_capacity = 50
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.ecs.id
        version            = "$Latest"
      }
    }
  }

  tag {
    key                 = "Name"
    value               = "${var.suffix}-asg-instance"
    propagate_at_launch = true
  }
}