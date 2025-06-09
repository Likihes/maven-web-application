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
	 stage("Test_Parallel"){
            parallel{
                stage("complile"){
                    steps{
                        sh 'mvn clean compile'
                    }
                }

                stage("junit_testS"){
                    steps{
                        sh 'mvn clean test'
                    }
                }
            }
        }
       	stage("Build War"){
            steps{
                sh 'mvn clean package'
            }
       	 }	
	}
    }
}
