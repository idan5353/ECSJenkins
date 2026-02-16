#!/bin/bash
set -e

# Update system
sudo yum update -y

# Install Java 17 (required for Jenkins 2.5xx+)
sudo yum install java-17-amazon-corretto -y

# Verify Java 17 is installed and set as default
sudo alternatives --set java /usr/lib/jvm/java-17-amazon-corretto.x86_64/bin/java

# Add Jenkins repository
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
sudo yum install jenkins -y

# Ensure JAVA_HOME is set for Jenkins
echo 'JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto.x86_64' | sudo tee -a /etc/sysconfig/jenkins

# Reload systemd and start Jenkins
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Install Docker
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker

# Add jenkins user to docker group
sudo usermod -aG docker jenkins

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws

# Install Git
sudo yum install git -y

# Restart Jenkins to apply docker group changes
sudo systemctl restart jenkins

# Print initial admin password location
echo "========================================="
echo "Jenkins is installed and running!"
echo "Initial admin password location:"
echo "/var/lib/jenkins/secrets/initialAdminPassword"
echo "========================================="
