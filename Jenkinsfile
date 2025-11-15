pipeline {
   agent any
environment { 
   NAME = "jenkinspipelineforonlinebookstore"
   VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
   IMAGE = "${NAME}:${VERSION}"
   IMAGE_REPO="jyotipmohapatra"
   IMAGE_URL='hub.docker.com'
   
}   

  stages {
    stage('Cloning Git') {
      steps {
      //git branch: 'main', url: 'https://github.com/git-jyoti/onlinebookstore.git'
        git url:'https://github.com/git-jyoti/onlinebookstore.git', branch: 'main'
      }
    }
    stage('Compile Package and Create war file') {
      steps { 
        sh "mvn package"
      }
    }
 }
}
