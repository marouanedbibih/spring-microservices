pipeline {
    agent any

    tools{
        jdk 'jdk-21.0.5'
        maven 'maven-3.8.7'
    }
    
    environment {
        DOCKER_CREDENTIALS_ID = 'docker-marouanedbibih'  
        DOCKER_IMAGE_NAME = 'marouanedbibih/ace-gateway-ms'  
        SCANNER_HOME = tool 'sonarqube-scanner'
    }

    stages {
        stage('Git Checkout'){
            git branh: 'main', credentialsId: 'github', url: 'url-of-github'
        }

        stage('Client Microservice'){
            stages{
                stage('Run Tests'){
                    steps{
                        dir('client-ms'){
                            sh 'mvn test'
                        }
                    }
                }

                stage('SonarQube'){
                    steps{
                        dir('client-ms'){
                            withSonarQubeEnv('soanarqube'){
                                sh """
                                ${SCANNER_HOME}/bin/sonar-scanner \
                                -Dsonar.projectName=client-microservice \
                                -Dsonar.projectKey=client-microservice \
                                -Dsonar.sources=src/main/java \
                                """
                            }
                        }
                    }
                }

                stage("Build JAR"){
                    steps{
                        dir('client-ms'){
                            script{
                                sh 'mvn clean package'
                            }
                        }
                    }
                }

                stage("Build Docker Image"){
                    steps{
                        dir('client-ms'){
                            script{
                                sh 'docker build -t ${DOCKER_IMAGE}:latest .'
                            }
                        }
                    }
                }

                stage("Push Docker Hun"){
                    steps{
                        dir("client-ms"){
                            withDockerRepository([credentialsId:'DOCKER_CREDENTIALS_ID' ]){
                                sh "docker push ${DOCKER_IMAGE}:latest"
                            }
                        }
                    }
                }

                stage("Deploy"){
                    steps{
                        dir("client-ms"){
                            script{
                                sh """
                                    docker compose down
                                    docker compose up -d
                                """
                            }

                        }
                    }
                }
            }
        }
    }


}