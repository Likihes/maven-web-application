pipeline {
    agent any
    stages { 
        stage('') {
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
    }
}

