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

## AI / Tools Used

AI tools were used to assist with structuring, validation, and improving clarity of the solution. All outputs were reviewed, understood, and adapted to match production-grade requirements.

### Tools Used

#### 1. ChatGPT and  GitHub Copilot(vscode)
Used for:
- Clarifying ECS + ASG + Capacity Provider interactions
- Structuring Terraform modules and best practices
- Validating security configurations (IAM, SSM, networking)
- Improving documentation quality (README, DESIGN, ADDENDUM)
- Preparing for failure scenarios and interview-style reasoning

#### 2. DiagramGPT (or similar tool)
Used for:
- Generating architecture diagrams
- Visualizing Multi-AZ layout and traffic flow
- Iterating on diagram clarity and reducing complexity

---

## How AI Was Used (Important Clarification)

- AI was used as a **supporting tool**
- All configurations were **manually reviewed and understood**
- Design decisions (e.g., capacity provider strategy, zero-downtime deployment, secrets handling) were **validated with AWS best practices**
- Final implementation reflects **engineering judgment and production reasoning**

---

## Why This Matters

Using AI tools helped:
- Accelerate development within the time constraint
- Explore multiple design approaches quickly
- Improve clarity and communication of the architecture

However, correctness, security, and design decisions were **carefully verified before inclusion**