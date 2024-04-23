pipeline {
    agent any

    tools {
        maven "maven-3.9.6"
    }
    stages {
        stage('1. Git Checkout') {
            steps {
                git branch: 'main', credentialsId: 'github-token', url: 'https://github.com/devops-project-2024/source-code.git'
            }
        }
        stage('2. Maven Build and Test') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('3. SonarQube analysis') {
            steps {
                sh 'mvn sonar:sonar'
                }
            }
        stage('4. Build and Push Docker Image') {
            environment {
                DOCKER_IMAGE = "emortoo/crispy-kitchen-project:${BUILD_NUMBER}"
                // DOCKERFILE_LOCATION = "Dockerfile"
                REGISTRY_CREDENTIALS = credentials('docker-cred')
            }
              steps {
                    script {
                        sh 'docker build -t ${DOCKER_IMAGE} .'
                        def dockerImage = docker.image("${DOCKER_IMAGE}")
                        docker.withRegistry('https://index.docker.io/v1/', "docker-cred") {
                            dockerImage.push()
                        }
                     }
                }
        }
        stage('5. Update Deployment File') {
            environment {
                GIT_REPO_NAME = "source-code"
                GIT_USER_NAME = "devops-project-2024"
            }
            steps {
                withCredentials([gitUsernamePassword(credentialsId: 'github-token', variable: 'GITHUB_TOKEN', gitToolName: 'Default')]) {
                    sh '''
                        git config user.email "emortoo@yahoo.com"
                        git config user.name "Emmanuel Mortoo"
                        BUILD_NUMBER=${BUILD_NUMBER}
                        sed -i "s/replaceImageTag/${BUILD_NUMBER}/g" dev-manifests/deployment.yml
                        git add .
                        git commit -m "Update deployment image to version ${BUILD_NUMBER}"
                        git push https://$GITHUB_TOKEN@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
                    '''
                }
            }
        }
    }
}