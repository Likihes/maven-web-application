pipeline {
    agent any
    tools{
        maven 'maven'
    }
    environment {
        DOCKERHUB_REPO = 'liki27/java-webapp-docker'
    }
    stages { 
        stage('Checkout') {
            steps {
                checkout scmGit(
			branches: [[name: '*/master']], 
			userRemoteConfigs: [[
				credentialsId: 'github_creditial', 
				url: 'https://github.com/Likihes/maven-web-application.git'
			]]
		)
            }
	}
	    stage('maven build'){
	    	steps {
			sh 'mvn clean package'
		}
	    }	
	    stage("Build Docker_Images"){
            steps{
                script {
                    def imageName = "${env.DOCKERHUB_REPO}:${env.BUILD_NUMBER}"
                    sh "docker build -t ${imageName} ."
                }
            }
        }
}
}
