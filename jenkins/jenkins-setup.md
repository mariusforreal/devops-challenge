# Jenkins Setup

This document outlines the steps to set up Jenkins on AWS for the LightFeather DevOps coding challenge.

## Infrastructure Components

1. **EC2 Instance**: t3.medium with Amazon Linux 2
2. **Security Group**: Allows inbound traffic on ports 22 (SSH), 8080 (Jenkins), and 443 (HTTPS)
3. **IAM Role**: Grants permissions to interact with AWS services (ECR, ECS)
4. **Elastic IP**: For a stable public IP address

## Installation Steps

### 1. Create an EC2 Instance

1. Launch an EC2 instance using Amazon Linux 2
2. Select t3.medium as the instance type
3. Configure the security group to allow inbound traffic on ports 22, 8080, and 443
4. Attach an IAM role with necessary permissions
5. Allocate an Elastic IP and associate it with the instance

### 2. Install Jenkins

Connect to your EC2 instance and run the following commands:

```bash
# Update system packages
sudo yum update -y

# Install Java
sudo amazon-linux-extras install java-openjdk11 -y

# Add Jenkins repository
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io-2023.key

# Install Jenkins
sudo yum install jenkins -y

# Start Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

### 3. Install Docker

```bash
# Install Docker
sudo yum install docker -y

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add jenkins user to docker group
sudo usermod -aG docker jenkins

# Restart Jenkins to apply changes
sudo systemctl restart jenkins
```

### 4. Install AWS CLI

```bash
# Install AWS CLI
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
```

### 5. Configure Jenkins

1. Access Jenkins via your browser at `http://<elastic-ip>:8080`
2. Retrieve the initial admin password:
   ```bash
   sudo cat /var/lib/jenkins/secrets/initialAdminPassword
   ```
3. Install suggested plugins
4. Create an admin user
5. Configure AWS credentials in Jenkins:
   - Go to 'Manage Jenkins' > 'Manage Credentials' > 'System' > 'Global credentials'
   - Add AWS credentials with ID 'aws-credentials'
   - Add ECR repository URLs as credentials with IDs 'ECR_FRONTEND_REPO' and 'ECR_BACKEND_REPO'
   - Add frontend and backend URLs with IDs 'FRONTEND_URL' and 'BACKEND_URL'

### 6. Create Jenkins Pipeline

1. Create a new pipeline job
2. Configure it to use the Jenkinsfile from your repository
3. Trigger the pipeline manually or set up a webhook for automatic triggering

## IAM Permissions

The IAM role attached to the EC2 instance should have the following policies:

- AmazonECR-FullAccess
- AmazonECS-FullAccess
- AmazonEC2ContainerRegistryFullAccess

## Security Considerations

- Restrict security group rules to only necessary IP ranges
- Use HTTPS for Jenkins with a valid SSL certificate
- Use IAM roles with least privilege
- Regularly update Jenkins and installed plugins