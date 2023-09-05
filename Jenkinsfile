pipeline {
    agent any

    stages {
        stage('Checkout Source Code') {
            steps {
                checkout scm
            }
        }

        stage('Building Docker Image') {
            steps {
                script {
                    def imageName = 'my-web-app:1.0'  // Specify the image name and tag
                    def dockerfile = './Dockerfile'  // Path to my Dockerfile reposiyory
                    def destinationImageName = 'docker10hub/hello:1.0'
                    // Building the Docker image
                    docker.build(imageName, "-f ${dockerfile} .")
                    // Tag the image
                    sh "docker tag ${imageName} ${destinationImageName}"
                }
            }
        }
        stage('Pushing Docker Image to Registry') {
            steps {
                script {
                    // Definition of the Docker image name and tag
                    def dockerimageName = 'docker10hub/hello:1.0'  // Image name and tag
                    def dockerHubAccessToken = 'dckr_pat_B1Ny25usdkb8C8QB7JKWPiwGF4U'  // Docker Hub access token.I did this because, when i try to connect dockerHub, i got some problem.
                    def dockerHubCredentialID = 'docker-token-credential' //Credential already have in Jenkins Credential
                    

                    // Log in to Docker Hub using the access token
                    withCredentials([string(credentialsId: dockerHubCredentialID, variable: 'DOCKERHUB_CREDENTIALS')]) {  
                        sh "echo ${dockerHubAccessToken} | docker login -u docker10hub --password-stdin docker.io"
                    }
                    // Pushing the Docker image to Docker Hub
                    sh "docker push ${dockerimageName}"
                    
                }
            }    
        }
        stage('Deploy the Docker Image to kubernetes Cluster') {
            steps {
                script {
                    // Loading SSH credentials by ID
                    def sshCredentials = credentials('SSH') // SSH connection to Kubernetes node on Server 2.
                    // Execute an SSH command
                    sshCommand remote: '10.153.2.130',
                               credentials: sshCredentials,
                               command: 'echo "Hello from Server3!"'

                    //sh 'curl -o kubernetes-hello-world.yaml https://github.com/osmangithub10/local2/blob/main/kubernetes-hello-world' // Pull the yaml file from git.
                    // Use kubectl to apply my Kubernetes manifests deployment
                    sh 'kubectl apply -f /home/osman/kubernetes-hello-world.yaml'
            
                }
            }
        }
    }
}



