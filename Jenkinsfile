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
                    def registryUrl = 'your-registry-url'  // Replace with your Docker registry URL
                    def registryUsername = 'your-registry-username'  // Replace with your registry username
                    def registryPassword = 'your-registry-password'  // Replace with your registry password

                    // Log in to the Docker registry
                    docker.withRegistry(registryUrl, registryUsername, registryPassword) {
                        docker.image(imageName).push()
                    }
                }
            }    
        }   
    }
}



