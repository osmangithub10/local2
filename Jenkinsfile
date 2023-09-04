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
                    def destinationImageName = 'docker10hub/hello:1.0'
                    // Build the Docker image
                    docker.build(imageName, "-f ${dockerfile} .")
                    // Tag the image
                    sh "docker tag ${imageName} ${destinationImageName}"
                }
            }
        }
        stage('Push Docker Image to Registry') {
            steps {
                script {
                    // Define the Docker image name and tag
                    //def dockerimageName = 'my-web-app:1.0'  // Replace with your image name and tag
                    def dockerimageName = 'docker10hub/hello:1.0'  // Replace with your image name and tag
                    def dockerHubAccessToken = 'dckr_pat_B1Ny25usdkb8C8QB7JKWPiwGF4U'  // Replace with your Docker Hub access token
                    def dockerHubCredentialID = 'docker-token-credential'
                    

                    // Log in to Docker Hub using the access token
                    withCredentials([string(credentialsId: dockerHubCredentialID, variable: 'DOCKERHUB_CREDENTIALS')]) {
                        sh "echo ${dockerHubAccessToken} | docker login -u docker10hub --password-stdin docker.io"
                    }
                    // Push the Docker image to Docker Hub
                    //docker.image(imageName).push()
                    sh "docker push ${dockerimageName}"
                    
                }
            }    
        }
        stage('SSH to Remote Server') {
            steps {
                script {
                    // Load SSH credentials by ID
                    def sshCredentials = credentials('SSH')

                    // Execute an SSH command
                    sshCommand remote: '10.153.2.130',
                               credentials: sshCredentials,
                               command: 'echo "Hello from Jenkins!"'


                    // Use kubectl to apply your Kubernetes manifests (e.g., Deployment, Service)
                    sh 'kubectl apply -f kubernetes-hello-world.yaml'
            
        


                    
                }
            }
        }





        
           
    }
}



