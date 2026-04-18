variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets for ALB"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnets for ECS"
  type        = list(string)
}

variable "ssm_param_arn" {
  description = "SSM Parameter ARN"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "Initial instances"
  type        = number
  default     = 2
}

variable "min_capacity" {
  description = "Minimum instances"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum instances"
  type        = number
  default     = 6
}

variable "suffix" {
    description = "A unique suffix to append to resource names"
    default     = "id-aws-test"
}

variable "certificate_arn" {
  description = "ACM SSL certificate ARN for HTTPS"
  type        = string
  default     = ""  
}

variable "ecs_instance_profile_arn" {
  description = "IAM instance profile ARN for ECS instances"
  type        = string
  default     = ""  
}

variable "private_route_tables" {
  description = "List of route table IDs for VPC endpoints"
  type        = list(string)
  default     = []  
}