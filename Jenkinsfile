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
                        sh 'chmod +x build.sh'
                        def buildOutput = sh(script: './build.sh', returnStdout: true).trim()
                        def imageCount = buildOutput.tokenize(':').last()  // Extract the image count
                        echo "Image count: ${imageCount}"
                        sh 'chmod +x deploy.sh'
                        sh "./deploy.sh devchanged ${imageCount}" // Pass only the image count
                    } else if (env.BRANCH_NAME == 'main') {
                        def logOutput = sh(script: 'git log --pretty=%B -1', returnStdout: true)
                        if (logOutput.trim().contains('Merge')) {
                            def mergedBranch = logOutput.trim().split('from ')[1].split(' ')[0]
                            if (mergedBranch == 'master') {
                                sh 'chmod +x build.sh'
                                def buildOutput = sh(script: './build.sh', returnStdout: true).trim()
                                def imageCount = buildOutput.tokenize(':').last()  // Extract the image count
                                echo "Image count: ${imageCount}"
                                sh 'chmod +x deploy.sh'
                                sh "./deploy.sh devmergedmaster ${imageCount}" // Pass only the image count
                            } else {
                                echo "Skipping build - Branch: ${env.BRANCH_NAME} (not from master merge)"
                            }
                        } else {
                            echo "Skipping build - Branch: ${env.BRANCH_NAME} (not a merge)"
                        }
                    } else {
                        echo "Skipping build - Branch: ${env.BRANCH_NAME}"
                    }
                }
            }
        }
    }
}

