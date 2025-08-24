pipeline {
    agent {
        docker {
            image 'python:3.11-slim'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh 'pip install --upgrade pip'  // upgrade pip just in case
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
                // Stop any previous container first (optional, prevents conflicts)
                sh '''
                if [ $(docker ps -q -f name=flask-jenkins-pipeline) ]; then
                    docker stop flask-jenkins-pipeline
                    docker rm flask-jenkins-pipeline
                fi
                '''

                sh 'docker run -d --name flask-jenkins-pipeline -p 5000:5000 flask-jenkins-pipeline'
            }
        }
    }
}
