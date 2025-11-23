pipeline {
  agent any
  environment {
    REGISTRY = 'REGISTRY_URL' // e.g. myregistry.corp.local:5000
    IMAGE_NAME = 'banking-app'
    K8S_NAMESPACE = 'banking'
  }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Build') {
      steps { sh 'mvn -B -DskipTests -f application/pom.xml clean package' }
    }
    stage('Unit Test') {
      steps { sh 'mvn -f application/pom.xml test' }
    }
    stage('SonarQube Analysis') {
      steps {
        withSonarQubeEnv('SonarQube') {
          sh 'mvn -f application/pom.xml sonar:sonar -Dsonar.projectKey=banking-app'
        }
      }
    }
    stage('Quality Gate') {
      steps {
        timeout(time: 5, unit: 'MINUTES') {
          waitForQualityGate abortPipeline: true
        }
      }
    }
    stage('Build Docker Image') {
      steps {
        script {
          sh "docker build -t ${REGISTRY}/${IMAGE_NAME}:${BUILD_NUMBER} -f docker/Dockerfile ."
        }
      }
    }
    stage('Docker Login & Push') {
      steps {
        withCredentials([string(credentialsId: 'REGISTRY_PASSWORD', variable: 'REGISTRY_PASSWORD'), usernamePassword(credentialsId: 'REGISTRY_CRED', usernameVariable: 'REGISTRY_USER', passwordVariable: 'REGISTRY_PASS')]) {
          sh '''
            echo "$REGISTRY_PASSWORD" | docker login ${REGISTRY} -u "$REGISTRY_USER" --password-stdin
            docker push ${REGISTRY}/${IMAGE_NAME}:${BUILD_NUMBER}
          '''
        }
      }
    }
    stage('Deploy to Kubernetes') {
      steps {
        sh "kubectl set image deployment/banking-app banking-app=${REGISTRY}/${IMAGE_NAME}:${BUILD_NUMBER} -n ${K8S_NAMESPACE} || kubectl apply -f kubernetes/deployment.yaml -n ${K8S_NAMESPACE}"
        sh "kubectl rollout status deployment/banking-app -n ${K8S_NAMESPACE} --timeout=120s"
      }
    }
  }
  post {
    success { echo 'Build and deploy successful' }
    failure { echo 'Build/Deploy failed' }
  }
}
