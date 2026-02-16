pipeline {
    agent any
    
    environment {
        AWS_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = credentials('aws-account-id')
        ECR_REPO_NAME = 'demo-app'
        ECS_CLUSTER = 'demo-cluster'
        ECS_SERVICE = 'ecs-fargate-demo-service'
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}"
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    dir('app') {
                        sh "docker build -t ${ECR_REPO_NAME}:${IMAGE_TAG} ."
                        sh "docker tag ${ECR_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}"
                        sh "docker tag ${ECR_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:latest"
                    }
                }
            }
        }
        
        stage('Login to ECR') {
            steps {
                script {
                    sh """
                        aws ecr get-login-password --region ${AWS_REGION} | \
                        docker login --username AWS --password-stdin ${REPOSITORY_URI}
                    """
                }
            }
        }
        
        stage('Push to ECR') {
            steps {
                script {
                    sh "docker push ${REPOSITORY_URI}:${IMAGE_TAG}"
                    sh "docker push ${REPOSITORY_URI}:latest"
                }
            }
        }
        
        stage('Deploy to ECS') {
            steps {
                script {
                    sh """
                        aws ecs update-service \
                            --cluster ${ECS_CLUSTER} \
                            --service ${ECS_SERVICE} \
                            --force-new-deployment \
                            --region ${AWS_REGION}
                    """
                }
            }
        }
        
        stage('Cleanup Local Images') {
            steps {
                script {
                    sh "docker rmi ${ECR_REPO_NAME}:${IMAGE_TAG} || true"
                    sh "docker rmi ${REPOSITORY_URI}:${IMAGE_TAG} || true"
                    sh "docker rmi ${REPOSITORY_URI}:latest || true"
                }
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline succeeded! Application deployed to ECS Fargate.'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}
