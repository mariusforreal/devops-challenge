# LightFeather DevOps Challenge

This repository contains the solution for the LightFeather DevOps Engineer Coding Challenge. It demonstrates the deployment of a React frontend and Express backend to AWS ECS using Terraform and Jenkins.

## Architecture Overview

The solution consists of the following components:

1. **Jenkins Server**: Provides CI/CD pipeline for automation
2. **AWS ECS**: Runs the frontend and backend as containerized applications
3. **AWS ECR**: Stores Docker images for the frontend and backend
4. **AWS Load Balancers**: Expose the frontend and backend services
5. **Terraform**: Provisions the necessary AWS infrastructure

## Prerequisites

- AWS Account with appropriate permissions
- Docker installed locally
- Terraform installed locally
- Git installed locally

## Deployment Steps

### 1. Set up Jenkins

Follow the instructions in [jenkins-setup.md](jenkins/jenkins-setup.md) to set up Jenkins on AWS.

### 2. Provision Infrastructure

```bash
# Initialize Terraform
cd terraform
terraform init

# Plan the infrastructure changes
terraform plan -out=tfplan

# Apply the infrastructure changes
terraform apply tfplan
```

### 3. Set up Jenkins Pipeline

1. Create a new pipeline job in Jenkins
2. Configure it to use the Jenkinsfile from this repository
3. Add the necessary credentials to Jenkins:
   - AWS credentials
   - ECR repository URLs
   - Frontend and backend URLs

### 4. Run the Pipeline

Trigger the Jenkins pipeline to build and deploy the application.

## Application Access

After successful deployment, you can access the frontend application at the URL provided by the Terraform output:

```bash
terraform output frontend_url
```

## Infrastructure Components

### Frontend

- React application
- Runs on AWS ECS Fargate
- Exposed through Application Load Balancer

### Backend

- Express application
- Runs on AWS ECS Fargate
- Exposed through Application Load Balancer

### Jenkins

- Runs on EC2 instance
- Accessible via Elastic IP
- Has necessary permissions to interact with AWS services

## Clean Up

To clean up the resources created by this solution:

```bash
# Destroy Terraform-managed resources
cd terraform
terraform destroy

# Manually delete Jenkins-related resources (EC2, security group, etc.)
```

## Troubleshooting

### Jenkins Pipeline Failures

- Check Jenkins logs for error messages
- Ensure AWS credentials are correctly configured
- Verify that ECR repositories exist and are accessible

### Application Connectivity Issues

- Check security group rules to ensure proper inbound/outbound traffic
- Verify that environment variables are correctly set in ECS task definitions
- Check application logs in CloudWatch