pipeline {
    environment {
        imagename = "marlapativ/static-site"
        registryCredential = 'dockerhub'
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
        stage('Setup Docker') {
            steps {
                sh '''
                    if [ -n "$(docker buildx ls | grep multiarch)" ]; then
                        docker buildx use multiarch
                    else
                        docker buildx create --name=multiarch --driver=docker-container --use --bootstrap 
                    fi
                '''
                
                script {
                    withCredentials([usernamePassword(credentialsId: registryCredential, passwordVariable: 'password', usernameVariable: 'username')]) {
                        sh('docker login -u $username -p $password')
                    }
                }
            }
        }
        stage('Generate Version') {
            tools {
                nodejs "nodejs"
            }
            steps {
                sh '''
                    npx semantic-release \
                        -p @semantic-release/changelog \
                        -p @semantic-release/commit-analyzer \
                        -p @semantic-release/release-notes-generator \
                        -p @semantic-release/github \
                        -p @semantic-release/git
                '''
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                sh '''
                    docker buildx build \
                    --platform linux/amd64,linux/arm64 \
                    --builder multiarch \
                    -t $imagename:latest \
                    -t $imagename:$BUILD_TAG \
                    --push \
                    .
                '''
            }
        }
    }
}
