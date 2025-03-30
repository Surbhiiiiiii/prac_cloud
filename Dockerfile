# Use an official lightweight Node.js image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and install dependencies first (to leverage Docker caching)
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the application
COPY . .

# Expose the required port
EXPOSE 3000

# Command to run the script
CMD ["node", "app.js"]

# pipeline {
#     agent any
#     environment {
#         DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
#     }
#     stages {
#         stage('Clone Repository') {
#             steps {
#                 git branch: 'main', url: 'https://github.com/Surbhiiiiiii/prac_cloud.git'
#             }
#         }
#         stage('Build Docker Image') {
#             steps {
#                 sh '''
#                 docker build -t surbhi800/my-node-app:latest .
#                 '''
#             }
#         }
#         stage('Login to Docker Hub') {
#             steps {
#                 withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
#                     sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
#                 }
#             }
#         }
#         stage('Push Image to Docker Hub') {
#             steps {
#                 sh '''
#                 docker push surbhi800/my-node-app:latest
#                 '''
#             }
#         }
#         stage('Deploy on AWS EC2') {
#             steps {
#                 sshagent(credentials: ['ec2-key']) {
#                     sh '''
#                    ssh -o StrictHostKeyChecking=no ubuntu@35.93.98.4 <<EOF
# docker stop node-container || true
# docker rm node-container || true
# docker pull surbhi800/my-node-app:latest
# docker run -d --name node-container -p 3000:3000 surbhi800/my-node-app:latest
# EOF

#                     '''
#                 }
#             }
#         }
#     }
# }
