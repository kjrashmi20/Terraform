Terraform AWS Drift Detection Platform

Overview
Production-grade Terraform project demonstrating:
- Infrastructure as Code (IaC)
- Automated drift detection
- Event-driven anomaly detection
- CI/CD integration

 Architecture
- VPC, EC2
- S3 backend for Terraform state
- CloudTrail + EventBridge + Lambda for anomaly detection

Features
- Modular Terraform design
- Remote state management
- Drift detection using Terraform plan + jq
- Real-time infra monitoring

Tech Stack
- Terraform
- AWS
- Bash
- GitHub Actions
- jq
