pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker.hub-creds')
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout([$class: 'GitSCM', 
                          branches: [[name: '*/main']], 
                          userRemoteConfigs: [[url: 'https://github.com/nikitham1916-pixel/jenkins-flask-pipeline.git',
                                               credentialsId: 'docker.hub-creds']]])
            }
        }

        stage('Install & Test') {
            steps {
                sh '''
                    python3 -m venv venv
                    ./venv/bin/pip install --upgrade pip
                    ./venv/bin/pip install -r app/requirements.txt
                    export PYTHONPATH=$PWD
                    ./venv/bin/python -m pytest -v --cache-clear app/test_app.py
                '''
            }
        }

        stage('Build Docker Image') {
            when {
                expression { currentBuild.currentResult == 'SUCCESS' }
            }
            steps {
                sh '''
                    docker build -t nikitham1916/jenkins-flask:latest .
                '''
            }
        }

        stage('Push Docker Image') {
            when {
                expression { currentBuild.currentResult == 'SUCCESS' }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker.hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push nikitha1916/jenkins-flask:latest
                    '''
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
