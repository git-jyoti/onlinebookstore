pipeline {
   agent any
environment { 
   NAME = "onlinebookstore"
   VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
   IMAGE = "${NAME}:${VERSION}"
   IMAGE_REPO="jyotipmohapatra"
   IMAGE_URL='docker.io'
   
}   

  stages {
    stage('Cloning Git') {
      steps {
      git branch: 'main', url: 'https://github.com/git-jyoti/onlinebookstore.git'
      }
    }
    stage('Compile Package and Create war file') {
      steps { 
        sh "mvn package"
      }
    }
     stage('Build result') {
     steps {
            echo "Running ${VERSION} on ${env.JENKINS_URL}"
            //git branch: "${env.BRANCH_NAME}", url: 'https://github.com/Hemantakumarpati/OnlineBookStore.git'
            //echo "for brnach ${env.BRANCH_NAME}"
            sh "docker build -t ${NAME} ."
            sh "docker tag ${NAME}:latest ${IMAGE_REPO}/${NAME}:${VERSION}"
        }
    } 
     stage('Push result image') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockeruser', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
          sh "docker push ${IMAGE_REPO}/${NAME}:${VERSION}"
           
        }
      }
    }
   stage('Integrate Jenkins with EKS Cluster and Deploy App') {
    steps {
        withAWS(credentials: 'aws', region: 'ap-south-1') {
            script {
                // Update kubeconfig to connect to EKS
                sh 'aws eks update-kubeconfig --name poc-cluster --region ap-south-1'

                // Optional: Confirm connection
                sh 'kubectl get nodes'

                // Print image URL for debugging
                sh 'echo ${IMAGE_URL}/${IMAGE_REPO}/${NAME}:${VERSION}'

                // Apply Kubernetes manifests
                sh 'kubectl apply -f k8s-specifications/'

                // Update deployment image
                sh 'kubectl set image deployment/onlinebookstore onlinebookstore-container=${IMAGE_REPO}/${NAME}:${VERSION}'
            }
        }
    }
}
}
}
