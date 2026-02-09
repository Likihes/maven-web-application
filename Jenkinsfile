@Library('my_library@main') _

pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                script {
                    gitCheckout(
                        branch: 'master',
                        url: 'https://github.com/Likihes/maven-web-application.git',
                        credentialsId: 'PATGH'
                    )
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    echo "Building the project..."
                }
            }
        }
    }
}
