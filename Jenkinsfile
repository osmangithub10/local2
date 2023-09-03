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
                    def imageName = 'my-web-app:1.0'  // The same image name and tag from Step 1
                    docker.withRegistry('', 'docker-registry-credentials') {
                        // Push the Docker image to Docker Hub
                        docker.image(imageName).push()
                    }
                }
            }    
        }   
    }
}



