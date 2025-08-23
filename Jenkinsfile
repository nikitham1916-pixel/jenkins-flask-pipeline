pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker.hub-creds') // Replace with your actual Jenkins credential ID
        IMAGE_NAME = "nikitha1916/jenkins-flask" // Replace with your Docker image name
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Setup & Test') {
    steps {
        sh '''
            python3 -m venv venv && \
            . venv/bin/activate && \
            pip install --upgrade pip && \
            pip install -r app/requirements.txt && \
            ./venv/bin/pytest app/test_app.py
        '''
    }
}
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh """
                    echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin
                    docker push ${IMAGE_NAME}:latest
                    """
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
