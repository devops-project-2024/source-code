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
                            -Dsonar.projectKey=crispy \
                            -Dsonar.projectName='crispy' \
                            -Dsonar.host.url=http://54.210.238.151:9000 \
                            -Dsonar.token=sqp_d6ccd6cf464974d0cbbe55ef3d76c76aba81d803
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
                    script {
                sh 'pwd'  // Check current directory
                sh 'ls -la'  // List files to verify presence of the deployment.yml

                // Configuring Git
                sh 'git config --global user.email "emortoo@yahoo.com"'
                sh 'git config --global user.name "Emmanuel Mortoo"'
                sh 'git config --global credential.helper "!f() { echo username=\$GIT_USER_NAME; echo password=\$GITHUB_TOKEN; }; f"'

                // Update the deployment file
                sed -i '' "s/emortoo\\/crispy-kitchen:v1.0.0/emortoo\\/crispy-kitchen:v1.0.\$BUILD_NUMBER/g" dev-manifests/deployment.yml
                
                // Add and commit changes
                sh 'git add dev-manifests/deployment.yml'
                sh 'git commit -m "Update image version to ${env.BUILD_NUMBER}"'
                sh 'git push https://github.com/\$GIT_USER_NAME/\$GIT_REPO_NAME HEAD:main'
            
                }
            }
        }
    }
}