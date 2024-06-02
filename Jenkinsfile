pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps{
                cleanWs()
                checkout scm
            }
        }
    }
}
