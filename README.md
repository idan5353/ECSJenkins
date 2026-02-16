# ECS Fargate CI/CD Pipeline with Ansible, Jenkins & Monitoring

A production-ready DevOps project demonstrating Infrastructure as Code, configuration management, containerized application deployment, CI/CD automation, and observability on AWS.

![Architecture](https://img.shields.io/badge/AWS-ECS%20Fargate-orange) ![Terraform](https://img.shields.io/badge/IaC-Terraform-purple) ![Ansible](https://img.shields.io/badge/Config-Ansible-red) ![Jenkins](https://img.shields.io/badge/CI%2FCD-Jenkins-blue) ![Monitoring](https://img.shields.io/badge/Monitoring-Prometheus%20%7C%20Grafana-green)

## 📋 Overview

This project showcases a complete DevOps workflow for deploying a containerized Node.js application to AWS ECS Fargate with:
- **Infrastructure as Code** using Terraform
- **Configuration Management** using Ansible
- **CI/CD pipeline** using Jenkins
- **Container orchestration** with ECS Fargate
- **Monitoring & observability** using Prometheus and Grafana
- **High availability** with Application Load Balancer

## 🏗️ Architecture
![diagram](https://github.com/user-attachments/assets/c373a12d-96fa-46df-9389-d03a1cf52ff2)



## 🚀 Features

### Infrastructure
- ✅ **AWS ECS Fargate** - Serverless container orchestration
- ✅ **Application Load Balancer** - Traffic distribution and health checks
- ✅ **Amazon ECR** - Private Docker image registry
- ✅ **Default VPC** - Cost-optimized networking (no NAT Gateway)
- ✅ **IAM Roles & Policies** - Least-privilege security model
- ✅ **CloudWatch Logs** - Centralized logging

### Configuration Management
- ✅ **Ansible Playbooks** - Automated Jenkins configuration
- ✅ **Plugin Management** - Automated Jenkins plugin installation
- ✅ **Idempotent Configuration** - Repeatable, consistent setup
- ✅ **Dynamic Inventory** - AWS EC2 inventory support

### CI/CD
- ✅ **Jenkins Pipeline** - Automated build and deployment
- ✅ **Multi-stage Pipeline** - Build → Push → Deploy
- ✅ **Automated deployments** - Push to trigger ECS service updates
- ✅ **Docker integration** - Containerized application builds

### Monitoring
- ✅ **Prometheus** - Metrics collection and storage
- ✅ **CloudWatch Exporter** - AWS service metrics scraping
- ✅ **Grafana Dashboards** - Visual monitoring of ECS, ALB, and application
- ✅ **Real-time metrics** - CPU, memory, request rate, response time

## 📦 Tech Stack

| Component | Technology |
|-----------|-----------|
| **Infrastructure** | Terraform, AWS (ECS Fargate, ALB, ECR, EC2) |
| **Configuration** | Ansible |
| **CI/CD** | Jenkins, Docker |
| **Monitoring** | Prometheus, Grafana, CloudWatch Exporter |
| **Application** | Node.js, Express |
| **Language** | HCL, YAML, Bash, JavaScript, Groovy |

📊 Monitoring Metrics
The Grafana dashboard displays:

Metric	Description	Source
ECS CPU Utilization	Container CPU usage percentage	CloudWatch
ECS Memory Utilization	Container memory usage percentage	CloudWatch
ALB Request Rate	Requests per second	CloudWatch
ALB Response Time	Average response time in seconds	CloudWatch
Healthy Targets	Number of healthy ECS tasks	CloudWatch
🔄 CI/CD Pipeline
The Jenkins pipeline automates the following stages:

Checkout - Clone code from Git

Build - Build Docker image with build number tag

Login to ECR - Authenticate with AWS ECR

Push to ECR - Push Docker image (latest + build tag)

Deploy to ECS - Force new ECS service deployment

Cleanup - Remove local Docker images

Trigger a Deployment
bash
# Push code to trigger build
git add .
git commit -m "Update application"
git push origin main
Jenkins automatically:

Detects the commit

Builds new Docker image

Pushes to ECR with build number

Updates ECS service

![צילום מסך 2026-02-16 212346](https://github.com/user-attachments/assets/f218e4f9-250b-462b-b450-3a2fd94b5457)
![צילום מסך 2026-02-16 211904](https://github.com/user-attachments/assets/89179cf0-e0fa-4f06-8963-fedc7428272f)

