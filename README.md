# Production-Grade ECS (EC2) Deployment using Terraform

## Overview

This project provisions a production-grade containerized application using:

- AWS ECS (EC2 launch type)
- Application Load Balancer (ALB)
- Auto Scaling Group (ASG) with mixed instances (On-Demand + Spot)
- Capacity Provider for dynamic scaling
- SSM Parameter Store for secure secrets management

The architecture is designed for:

- High availability (Multi-AZ)
- Zero-downtime deployments
- Cost optimization
- Secure networking

---

## Architecture

User → Route53 → ALB (Public Subnets) → ECS Service → ECS Tasks → EC2 (ASG in Private Subnets)

---

## How to Run

```bash
terraform init
terraform plan -var-file="test.tfvars"
terraform apply -var-file="test.tfvars"