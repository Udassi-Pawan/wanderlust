pipeline {
    agent any

    options {
        disableConcurrentBuilds()       
        skipDefaultCheckout(true)        
    }


    environment {
        AWS_REGION = 'us-east-1'
        FRONTEND_IMAGE = '864899848137.dkr.ecr.us-east-1.amazonaws.com/wanderlust/frontend'
        BACKEND_IMAGE = '864899848137.dkr.ecr.us-east-1.amazonaws.com/wanderlust/backend'
        REMOTE_HOST = 'ubuntu@54.167.114.207' 
        AWS_ECR = '864899848137.dkr.ecr.us-east-1.amazonaws.com'
    }

    stages {
        
        
        
        
        stage('Clone Repo') {
    steps {
        checkout([$class: 'GitSCM',
            branches: [[name: '*/main']],
            userRemoteConfigs: [[url: 'https://github.com/Udassi-Pawan/wanderlust.git']]
        ])
    }
}

        

        stage('Login to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $FRONTEND_IMAGE
                '''
            }
        }

        stage('Build Docker Images') {
            steps {
                sh '''
                docker build -t $FRONTEND_IMAGE:latest ./frontend
                docker build -t $BACKEND_IMAGE:latest ./backend
                '''
            }
        }

        stage('Push to ECR') {
            steps {
                sh '''
                docker push $FRONTEND_IMAGE:latest
                docker push $BACKEND_IMAGE:latest
                '''
            }
        }

       stage('Deploy to Remote Server') {
    steps {
        sshagent(['temp-server']) {
            sh '''
            ssh -v -o StrictHostKeyChecking=no $REMOTE_HOST '
                aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 864899848137.dkr.ecr.us-east-1.amazonaws.com &&
                cd /home/ubuntu/wanderlust &&
                docker compose pull &&
                docker compose down &&
                docker compose up -d
            '
            '''
        }
    


            }
        }
    }

    post {
        failure {
            echo '❌ Deployment failed.'
        }
        success {
            echo '✅ Successfully deployed!'
        }
    }
}


