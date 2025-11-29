pipeline {
    agent any

    tools {
        // Ensure Ant and JDK are configured in Jenkins Global Tool Configuration
        ant 'ant'        // Replace with the name of your Ant installation
    }

    environment {
        APP_NAME   = 'onlinebookstore-antbuild'
        BUILD_DIR  = 'build'
        DIST_DIR   = 'dist'
    }

    stages {
        stage('Checkout') {
            steps {
                // Pull source code from SCM (GitHub/GitLab/etc.)
                checkout scm
            }
        }

        stage('Compile') {
            steps {
                // Run Ant compile target
                ant {
                    buildFile 'build.xml'
                    targets 'compile'
                }
            }
        }

        stage('Test') {
            steps {
                // Run Ant test target
                ant {
                    buildFile 'build.xml'
                    targets 'test'
                }
            }
        }

        stage('Package') {
            steps {
                // Run Ant distribution target
                ant {
                    buildFile 'build.xml'
                    targets 'dist'
                }
            }
        }

        stage('Archive Artifacts') {
            steps {
                // Archive JAR/WAR files produced by Ant
                archiveArtifacts artifacts: "${DIST_DIR}/**/*.jar", fingerprint: true
            }
        }

        stage('Deploy (Optional)') {
            when {
                branch 'branch1'
            }
            steps {
                echo "Deploying ${APP_NAME} build from ${DIST_DIR}..."
                // Add deployment steps here (e.g., copy to server, run scripts)
            }
        }
    }

    post {
        success {
            echo "✅ ${APP_NAME} build completed successfully!"
        }
        failure {
            echo "❌ ${APP_NAME} build failed. Check logs."
        }
        always {
            // Publish JUnit test results if Ant generates them
            junit '**/test-results/*.xml'
        }
    }
}
