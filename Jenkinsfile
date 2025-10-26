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
 }
}
