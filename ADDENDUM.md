# ADDENDUM.md

## 1. Spot Failure During Deployment (60% reclaimed)

### What happens:
- Spot instances are terminated
- ECS tasks on those instances stop

### System reaction:
- ASG launches new instances
- Capacity Provider triggers scaling
- ECS reschedules tasks

### Why no downtime:
- On-Demand baseline ensures minimum capacity
- ALB routes only to healthy tasks

---

## 2. Secrets Failure (SSM permission removed)

### What breaks:
- Task fails to fetch secret
- Container fails to start

### Detection:
- ECS task failures
- CloudWatch logs

### Recovery:
- Fix IAM policy
- Redeploy tasks

### Security:
- No secrets exposed (only referenced via ARN)

---

## 3. Pending Task Deadlock

### Scenario:
- Desired tasks: 10
- Running capacity: 6
- Pending: 4

### Flow:
- ECS detects insufficient capacity
- Capacity Provider triggers ASG scale-out
- New EC2 instances launched
- Pending tasks scheduled

### Why no deadlock:
- Managed scaling automatically increases capacity

---

## 4. Deployment Safety

- New tasks start first
- ALB routes only after health checks pass
- Old tasks drained before termination

### If new tasks fail:
- Traffic remains on old tasks
- Deployment halts safely

---

## 5. TLS, Trust Boundary, Identity

- TLS terminated at ALB
- ACM manages certificates
- Containers run with IAM task role
- Access limited to SSM parameter only

---

## 6. Cost Floor (No Traffic)

Even with zero traffic:

- Minimum 1 On-Demand instance running
- ALB still active

### Optimization:
- Reduce instance size
- Use scheduled scaling

---

## 7. Failure Modes

### A. AZ Failure
- ALB routes to healthy AZ
- ASG launches instances in remaining AZ

### B. Spot Interruption
- Instances replaced automatically
- Service remains available

### C. IAM Misconfiguration
- Tasks fail to start
- Detected via logs

---

## Operations (Alerts)

Top alerts:

1. ECS task failures
2. ALB 5xx errors
3. High CPU usage
4. ASG capacity issues
5. Unhealthy targets

---

## Summary

This design ensures:

- Zero downtime deployments
- Secure secrets handling
- Cost-efficient scaling
- High availability across AZs