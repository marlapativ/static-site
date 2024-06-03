pipeline {
    environment {
        imagename = "marlapativ/static-site"
        registryCredential = 'b78e5c66-9851-4a1d-972a-778416f55e00'
        dockerImage = ''
    }
    agent any
    stages {
        stage('Checkout') {
            when {
                branch 'main'
            }
            steps{
                cleanWs()
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                dockerImage = docker.build imagename
            }
        }
        stage ('Image Push') {
            steps {
                docker.withRegistry('https://registry.hub.docker.com', 'b78e5c66-9851-4a1d-972a-778416f55e00') {
                    dockerImage.push("$BUILD_TAG")
                    dockerImage.push('latest')
                }
            }
        }
    }
}
