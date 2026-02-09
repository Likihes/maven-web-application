@Library('my_library') _
pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                pipeline {
                    agent any
                    
                    stages {
                        stage('Checkout') {
                            steps {
                                script {
                                    def config = [
                                        branch: 'master',
                                        url: 'https://github.com/Likihes/maven-web-application.git',
                                        credentialsId: 'PATGH'
                                    ]
                                    gitCheckout(config)
                                }
                            }
                        }
                    }
                }
            }
        }
    }   
}               
