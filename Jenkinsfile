pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                script {
                    echo "Branch Name: ${env.BRANCH_NAME}"
                    git branch: "${env.BRANCH_NAME}", url: 'https://github.com/jayan/capstone-devops.git'
                }
            }
        }
        stage('Build and Push (Conditional)') {
            steps {
                script {
                    echo "Branch Name: ${env.BRANCH_NAME}"
                    if (env.BRANCH_NAME == 'master') {
                        sh 'chmod +x build.sh' // Assuming build.sh exists
                        sh './build.sh'
                        sh 'deploy.sh devchanged'
                    } else if (env.BRANCH_NAME == 'main' && env.CHANGE_TARGET == 'main') {
                        sh 'chmod +x build.sh' // Assuming build.sh exists
                        sh './build.sh'
                        sh 'deploy.sh devmergedmaster'
                    } else {
                        echo "Skipping build - Branch: ${env.BRANCH_NAME}"
                    }
                }
            }
        }
    }
}
