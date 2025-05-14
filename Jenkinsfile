pipeline {
  agent any

  environment {
    RAILS_ENV = 'test'
    DB_HOST = 'localhost'
    DB_USERNAME = 'postgres'
    DB_PASSWORD = 'password'
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/ralzate/task_manager_api' 
      }
    }

    stage('Build') {
      steps {
        sh 'docker-compose build'
      }
    }

    stage('Run Tests') {
      steps {
        sh 'docker-compose run --rm app bundle exec rspec'
      }
    }

    stage('Lint') {
      steps {
        sh 'docker-compose run --rm app bundle exec rubocop'
      }
    }

    stage('Push Docker Image') {
      when {
        branch 'main'
      }
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh """
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker tag nombre-app usuario/nombre-app:latest
            docker push usuario/nombre-app:latest
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
