pipeline {
    agent any

    stages {
        stage('Checkout Source Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def imageName = 'my-web-app:1.0'  // Specify the image name and tag
                    def dockerfile = './Dockerfile'  // Path to your Dockerfile within the repository

                    // Build the Docker image
                    docker.build(imageName, "-f ${dockerfile} .")
                }
            }
        }
        stage('Push Docker Image to Registry') {
            steps {
                script {
                    // Define the Docker image name and tag
                    def dockerimageName = 'my-web-app:1.0'  // Replace with your image name and tag
                    def dockerHubAccessToken = 'dckr_pat_B1Ny25usdkb8C8QB7JKWPiwGF4U'  // Replace with your Docker Hub access token
                    def dockerHubCredentialID = 'docker-token-credential'

                    // Log in to Docker Hub using the access token
                    withCredentials([string(credentialsId: dockerHubCredentialID, variable: 'DOCKERHUB_CREDENTIALS')]) {
                        sh "echo $DOCKERHUB_CREDENTIALS | docker login -u docker10hub --password-stdin docker.io"
                    }

                    // Push the Docker image to Docker Hub
                    //docker.image(imageName).push()
                    sh "docker push ${dockerimageName}"
                }
            }    
        }   
    }
}



