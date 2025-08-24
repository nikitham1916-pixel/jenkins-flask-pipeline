pipeline {
    agent any

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/nikitham1916-pixel/jenkins-flask-pipeline.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pip install -r app/requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'python app/test_app.py'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t flask-jenkins-pipeline .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d -p 5000:5000 flask-jenkins-pipeline'
            }
        }
    }
}
