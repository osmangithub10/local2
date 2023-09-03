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
                    def imageName2 = 'my-web-app:1.0'  // Replace with your image name and tag


                    // Log in to the Docker registry
                    docker.withRegistry([credentialsId:"docker-registry-credentials",url:""]) {
                        // Push the Docker image to the registry
                        docker.image(imageName2).push()
                    }
                }
            }
        }
           
    }
}



