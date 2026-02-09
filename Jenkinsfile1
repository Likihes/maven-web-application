pipeline {
    agent any
    tools{
        maven 'maven'
    }
    environment {
        DOCKERHUB_REPO = 'liki27/java-webapp-docker'
	DOCKERHUB_CREDENTIALS_ID = 'dockerhub_credentials'
	CONTAINER_NAME = 'javawebappcontainer'
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
	    stage("Docker login and push"){
            steps {
                withCredentials([usernamePassword(credentialsId: env.DOCKERHUB_CREDENTIALS_ID, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]){
                    script {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                        def imageName = "${env.DOCKERHUB_REPO}:${env.BUILD_NUMBER}"
                        sh "docker push ${imageName}"
                    }
                }
            }
        }
	    stage("deploy container") {
            steps {
                withCredentials([usernamePassword(credentialsId: env.DOCKERHUB_CREDENTIALS_ID, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sshagent(['Docker_ssh_ubuntu']) {
                        script {
                            def imageName = "${env.DOCKERHUB_REPO}:${env.BUILD_NUMBER}"
                            def containerName = "${env.CONTAINER_NAME}"
                            sh """
                                ssh -o StrictHostKeyChecking=no ubuntu@172.31.15.16 '
                                    echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin &&
                                    docker rm -f ${containerName} || true &&
                                    docker run -d -p 8080:8080 --name ${containerName} ${imageName}'
                            """
                        }
                    }
                }
            }
        }
}
}
