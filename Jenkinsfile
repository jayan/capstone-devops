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
            when {
                // Trigger the stage when the branch is 'master' or it's a pull request targeting 'main'
                expression { env.BRANCH_NAME == 'master' || (env.BRANCH_NAME == 'main' && env.PULL_REQUEST != null) }
            }
            steps {
                script {
                    echo "Branch Name: ${env.BRANCH_NAME}"
                    if (env.BRANCH_NAME == 'master') {
                        sh 'chmod +x build.sh'
                        def buildOutput = sh(script: './build.sh', returnStdout: true).trim()
                        def imageCount = buildOutput.tokenize(':').last()  // Extract the image count
                        def login = sh("docker login -u cjayanth -p dckr_pat_b7SY8aUaMHV1wGURqY4jQoukKNI")
                        echo "${login}"
                        echo "Image count: ${imageCount}"
                        sh 'chmod +x deploy.sh'
                        sh "./deploy.sh devchanged ${imageCount}" // Pass only the image count
                    } else {
                        // For pull requests targeting 'main'
                        def sourceBranch = env.CHANGE_BRANCH
                        echo "Source branch for merge: ${sourceBranch}"
                        // Your build and deploy logic here (optional)
                    }
                }
            }
        }
    }
}

