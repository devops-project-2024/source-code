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
                script {
                    scannerHome = tool 'sonarqube scanner'
                }
                    withSonarQubeEnv('sonar-server') {
                        sh """
                            ${scannerHome}/bin/sonar-scanner \
                            -Dsonar.projectKey=crispy-kitchen \
                            -Dsonar.projectName='crispy-kitchen' \
                            -Dsonar.host.url=http://54.210.238.151:9000/ \
                            -Dsonar.token=sqp_cebf052c3bec65bb94c81ed0bd5bbbf00d51ef96
                        """
                    }
            
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
                withCredentials([gitUsernamePassword(credentialsId: 'github-token', variable: 'GITHUB_TOKEN')]) {
                    sh """
                        # Configure Git to use the token for authentication
                        git config --global user.email "emortoo@yahoo.com"
                        git config --global user.name "Emmanuel Mortoo"
                        git config --global credential.helper '!f() { echo username=\$GIT_USER_NAME; echo password=\$GITHUB_TOKEN; }; f'

                        # Perform Git operations
                        sed -i '' "s/emortoo\\/crispy-kitchen:v1.0.5/emortoo\\/crispy-kitchen:v1.0.\$BUILD_NUMBER/g" dev-manifests/deployment.yml
                        git add dev-manifests/deployment.yml
                        git commit -m "Update deployment image to version \$BUILD_NUMBER"
                        git push https://github.com/\$GIT_USER_NAME/\$GIT_REPO_NAME HEAD:main
                    """
                }
            }
        }
    }
}