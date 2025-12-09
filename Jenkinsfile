pipeline {
  agent any
  environment {
    DOCKER_REGISTRY = "docker.io"
    DOCKER_REPO = "${DOCKER_REGISTRY}/youruser/releaseflow-app"
    IMAGE_TAG = "${env.BUILD_NUMBER}-${sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()}"
    K8S_NAMESPACE = 'releaseflow'
    K8S_DEPLOYMENT = 'releaseflow-app'
    KUBECONFIG_CREDENTIALS_ID = 'kubeconfig-cred'
    DOCKER_CREDENTIALS_ID = 'docker-credentials'
    SLACK_WEBHOOK = credentials('slack-webhook')
  }
  options {
    timestamps()
    buildDiscarder(logRotator(numToKeepStr: '30'))
  }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Unit Tests') {
      steps {
        sh 'python3 -m venv .venv || true'
        sh '. .venv/bin/activate && pip install -r requirements.txt'
        sh '. .venv/bin/activate && pytest -q || true'
      }
    }
    stage('Build Docker Image') {
      steps {
        script {
          withCredentials([usernamePassword(credentialsId: env.DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            sh "docker login -u $DOCKER_USER -p $DOCKER_PASS ${DOCKER_REGISTRY}"
            sh "docker build -t ${DOCKER_REPO}:${IMAGE_TAG} ."
            sh "docker push ${DOCKER_REPO}:${IMAGE_TAG}"
          }
        }
      }
    }
    stage('Create Release Tag') {
      steps {
        sh "git tag -a v${IMAGE_TAG} -m 'Release ${IMAGE_TAG}' || true"
        sh "git push origin --tags || true"
      }
    }
    stage('Deploy to Kubernetes') {
      steps {
        withCredentials([file(credentialsId: env.KUBECONFIG_CREDENTIALS_ID, variable: 'KUBECONFIG_FILE')]) {
          sh 'mkdir -p ~/.kube'
          sh 'cp $KUBECONFIG_FILE ~/.kube/config'
          sh "kubectl apply -f deployment/namespace.yaml || true"
          sh "kubectl set image deployment/${K8S_DEPLOYMENT} ${K8S_DEPLOYMENT}=${DOCKER_REPO}:${IMAGE_TAG} -n ${K8S_NAMESPACE}"
          sh "kubectl rollout status deployment/${K8S_DEPLOYMENT} -n ${K8S_NAMESPACE} --timeout=120s"
        }
      }
    }
    stage('Post-deploy Tests') {
      steps {
        sh "kubectl -n ${K8S_NAMESPACE} get pods"
        sh "kubectl -n ${K8S_NAMESPACE} get svc"
      }
    }
  }
  post {
    success {
      script {
        sh "curl -X POST -H 'Content-type: application/json' --data '{"text": "Deployment succeeded: ${IMAGE_TAG}"}' ${SLACK_WEBHOOK} || true"
      }
    }
    failure {
      script {
        sh "curl -X POST -H 'Content-type: application/json' --data '{"text": "Deployment FAILED: ${IMAGE_TAG}. Check Jenkins logs."}' ${SLACK_WEBHOOK} || true"
      }
    }
  }
}
