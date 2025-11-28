pipeline {
   agent any
   tools {
      maven 'maven'
   }
environment { 
   NAME = "onlinebookstore"
   VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
   IMAGE = "${NAME}:${VERSION}"
   IMAGE_REPO="jyotipmohapatra"
   IMAGE_URL='hub.docker.com'
   
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
    //stage('Integration tests') {
               // Run integration test
      //         steps {
        //           script {
          //             def mvnHome = tool '3.6.3'
            //           if (isUnix()) {
              //             // just to trigger the integration test without unit testing
                //           sh "'${mvnHome}/bin/mvn'  verify -Dunit-tests.skip=true"
                  //     } else {
                    //       bat(/"${mvnHome}\bin\mvn" verify -Dunit-tests.skip=true/)
                     //  }
   
                   //}
                   // cucumber reports collection
                   //cucumber buildStatus: null, fileIncludePattern: '**/cucumber.json', jsonReportDirectory: 'target', sortingMethod: 'ALPHABETICAL'
               //}
           //}
   stage('Build result') {
     steps {
            echo "Running ${VERSION} on ${env.JENKINS_URL}"
            //git branch: "${env.BRANCH_NAME}", url: 'https://github.com/git-jyoti/onlinebookstore.git'
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
     stage('Deploy to GKE') {
    steps {
        withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {

    sh """
        gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
        gcloud config set project clever-tracker-479504-p2
        gcloud container clusters get-credentials standard-public-cluster-1 --zone asia-south1

        kubectl apply -f k8s-specifications/
    """
}
}
}
}
}
