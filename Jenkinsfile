pipeline {
    agent any

    tools {
        maven 'Maven3'
    }

    environment {
        DOCKER_IMAGE = "pavant049/cicd-demo:latest"
    }

    stages {

        stage('1 - Checkout Code') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main',
                    url: 'https://github.com/pavan-t9/cicd-demo.git'
            }
        }

        stage('2 - Build with Maven') {
            steps {
                echo 'Building the project...'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('3 - Run Unit Tests') {
            steps {
                echo 'Running tests...'
                sh 'mvn test'
            }
        }

        stage('4 - Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('5 - Push to DockerHub') {
            steps {
                echo 'Pushing to DockerHub...'
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('6 - Cleanup') {
            steps {
                echo 'Removing local image...'
                sh "docker rmi ${DOCKER_IMAGE} || true"
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed! Image pushed to DockerHub.'
        }
        failure {
            echo '❌ Pipeline failed. Check logs above.'
        }
    }
}
