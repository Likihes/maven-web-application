pipeline {
    agent any
    tools{
        maven 'maven'
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
}
}
