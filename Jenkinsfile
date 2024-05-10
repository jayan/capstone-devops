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
                    def login = sh ('docker login -u cjayanth -p dckr_pat_IXH3dJctNsYfRzh2aVy_RN9-ftg')
                    echo "${login}"
                    if (env.BRANCH_NAME == 'master') {
                        sh 'chmod +x build.sh' // Assuming build.sh exists
                        def buildOutput = sh(script: './build.sh', returnStdout: true)
                        echo "${buildOutput}"
                        sh 'chmod +x deploy.sh'
                        sh './deploy.sh devchanged'
                    } else if (env.BRANCH_NAME == 'main' && env.CHANGE_TARGET == 'main') {
                        sh 'chmod +x build.sh' // Assuming build.sh exists
                        sh './build.sh'
                        sh 'chmod +x deploy.sh'
                        sh './deploy.sh devmergedmaster'
                    } else {
                        echo "Skipping build - Branch: ${env.BRANCH_NAME}"
                    }
                }
            }
        }
    }
}

