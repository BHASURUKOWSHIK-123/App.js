# AWS Region
region = "ap-south-1"

# VPC and Network Configuration
vpc_id = "vpc-0a1b2c3d4e5f67890"

public_subnets = [
  "subnet-0aaabbbccc1112223",
  "subnet-0dddeeefff4445556"
]

private_subnets = [
  "subnet-01112223334445556",
  "subnet-0777888999aaaabbb"
]

# Resource Naming
suffix = "id-aws-test"

# EC2 Instance Configuration
instance_type   = "t3.medium"

# Auto Scaling Group Configuration
desired_capacity = 2
min_capacity     = 1
max_capacity     = 5

# SSM Parameter for application secrets
ssm_param_arn = "arn:aws:ssm:ap-south-1:123456789012:parameter/my-secret"

# SSL Certificate for HTTPS 
certificate_arn = "arn:aws:acm:ap-south-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"

# IAM Instance Profile for ECS 
ecs_instance_profile_arn = "arn:aws:iam::123456789012:instance-profile/ecsInstanceProfile"


private_route_tables = [
  "rtb-0a1b2c3d4e5f67890",
  "rtb-0dddeeefff4445556"
]