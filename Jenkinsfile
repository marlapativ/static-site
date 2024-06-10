pipeline {
    environment {
        imagename = "marlapativ/static-site"
        registryCredential = 'dockerhub'
    }
    agent any
    stages {
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
                script {
                    withCredentials([usernamePassword(credentialsId: github, passwordVariable: 'GITHUB_TOKEN')]) {
                        sh '''
                            npx semantic-release \
                                -p @semantic-release/commit-analyzer \
                                -p @semantic-release/release-notes-generator \
                                -p @semantic-release/github
                        '''
                    }
                }
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                sh '''
                    export IMAGE_TAG=$(git describe --tags --abbrev=0)
                '''

                sh '''
                    docker buildx build \
                    --platform linux/amd64,linux/arm64 \
                    --builder multiarch \
                    -t $imagename:latest \
                    -t $imagename:$IMAGE_TAG \
                    --push \
                    .
                '''
            }
        }
    }
}
