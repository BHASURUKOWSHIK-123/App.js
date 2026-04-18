resource "aws_iam_role" "ecs_execution" {
  name = "${var.suffix}-ecsExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ecs-tasks.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}
 
resource "aws_iam_role_policy_attachment" "ecs_exec_attach" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "task_role" {
  name = "${var.suffix}-ecsTaskRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ecs-tasks.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "ssm_policy" {
  name = "${var.suffix}-ssm-access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["ssm:GetParameter"],
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "task_attach" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.ssm_policy.arn
}

# ============================================================
# EC2 Instance Role (for ASG instances)
# ============================================================

resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.suffix}-ecs-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach ECS Task Execution Policy to EC2 instances
resource "aws_iam_role_policy_attachment" "ecs_instance_policy" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# Attach SSM policy to EC2 instances
resource "aws_iam_role_policy_attachment" "ecs_ssm_policy" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Create Instance Profile for EC2 instances
resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "${var.suffix}-ecs-instance-profile"
  role = aws_iam_role.ecs_instance_role.name
}
