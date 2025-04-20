pipeline {
  agent any
  environment {
    IMAGE = 'ghcr.io/abo1406/myhttpd-app'
    
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Build & Push Docker') {
      steps {
        sh 'docker build -t ${IMAGE}:${env.BUILD_NUMBER} .'
        withDockerRegistry([credentialsId: 'dockerhub-cred']) {
          sh 'docker push ${IMAGE}:${env.BUILD_NUMBER}'
        }
        script {
          env.IMAGE_TAG = "${env.BUILD_NUMBER}"
        }
      }
    }

    stage('Terraform Deploy') {
      steps {
        dir('terraform/environments/${env.DEPLOY_ENV}') {
          sh 'terraform init'
          sh 'terraform apply -auto-approve -var "image_tag=${env.IMAGE_TAG}"'
          script {
            env.APP_URL = sh(script: 'terraform output -raw app_url', returnStdout: true).trim()
          }
        }
      }
    }

    stage('Smoke Test') {
      steps {
        sh 'curl -f ${env.APP_URL}'
      }
    }
  }
}
