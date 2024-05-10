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
                        def login = sh("docker login -u cjayanth -p dckr_pat_b7SY8aUaMHV1wGURqY4jQoukKNI")
                        echo "${login}"
                        echo "Image count: ${imageCount}"
                        sh 'chmod +x deploy.sh'
                        sh "./deploy.sh devchanged ${imageCount}" // Pass only the image count
                    } else if (env.BRANCH_NAME == 'main') {
                        def commitId = sh(script: "git log --pretty=%P -n 1 HEAD", returnStdout: true).trim()
                        def parentCommits = commitId.tokenize(' ')
                        if (parentCommits.size() > 1) {
                            def mergedBranch = sh(script: "git branch --contains ${commitId}", returnStdout: true).trim()
                            echo "Merged branch: ${mergedBranch}"
                            if (mergedBranch.trim() == '* master') {
                                echo "Merged from master, executing build and deploy..."
                                sh 'chmod +x build.sh'
                                sh './build.sh'
                                sh 'chmod +x deploy.sh'
                                sh './deploy.sh'
                            } else {
                                echo "Not merged from master, skipping build and deploy."
                            }
                        } else {
                            echo "Not a merge commit, skipping build and deploy."
                        }
                    } else {
                        echo "Skipping build and deploy for branch: ${env.BRANCH_NAME}"
                    }
                }
            }
        }
    }
}
