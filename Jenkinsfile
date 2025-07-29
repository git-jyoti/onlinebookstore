pipeline {
   agent any
environment { 
   NAME = "onlinebookstore"
   VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
   
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

 }
}
