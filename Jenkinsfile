pipeline {
    environment {
        imagename = "marlapativ/static-site"
        registryCredential = 'docker'
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
                script {
                    dockerImage = docker.build(imagename,  '--platform linux/amd64,linux/arm64 --builder multiarch .')
                    dockerImage.tag("$BUILD_TAG")
                }
            }
        }
        stage ('Image Push') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }
}
