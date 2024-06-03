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
        stage('Setup Docker') {
            steps {
                sh '''
                    if [ "$(docker buildx ls | grep multiarch)" -eq 1 ]; then
                        docker buildx create --name=multiarch --driver=docker-container --use --bootstrap 
                    else
                        docker buildx use multiarch
                    fi
                '''
                
                script {
                    withCredentials([usernamePassword(credentialsId: registryCredential, passwordVariable: 'password', usernameVariable: 'username')]) {
                        sh('echo $password | docker login -u $username --password-stdin')
                    }
                }
                
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
