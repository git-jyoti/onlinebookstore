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
        git 'https://github.com/git-jyoti/onlinebookstore.git'
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

 }
}
