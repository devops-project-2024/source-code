pipeline {
    agent any

    tools {
        maven "maven-3.9.6"
    }
    stages {

        stage('1. Git Checkout') {
           steps {
                git(credentialsId: 'github-token', url: 'https://github.com/devops-project-2024/source-code.git', branch: 'main')
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
                            -Dsonar.sources=. \
                            -Dsonar.host.url=http://54.152.57.191:9000 \
                            -Dsonar.token=sqp_5a95ca9e65314f427a80ec9bcfc4f8629916e31b
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

        stage('5. Checkout manifest SCM') {
            steps {
                git(credentialsId: 'github-token', 
                    url: 'https://github.com/devops-project-2024/manifest-file.git',
                    branch: 'main')
            }
        }


        stage('6. Update Deployment File') {
            environment {
                GIT_REPO_NAME = "manifest-file"
                GIT_USER_NAME = "devops-project-2024"
            }
            steps {
                withCredentials([string(credentialsId: 'github-token', variable: 'GITHUB_TOKEN')]) {
                    script {
                        sh """
                            cat dev-manifests/deployment.yml
                            sed -i 's|emortoo/crispy-kitchen:v1.0.0|emortoo/crispy-kitchen:v1.0.\${BUILD_NUMBER}|g' dev-manifests/deployment.yml
                            cat dev-manifests/deployment.yml
                            git config user.email 'you@example.com'  // Set your email
                            git config user.name 'Your Name'  // Set your name
                            git add dev-manifests/deployment.yml
                            git commit -m 'Updated the dev-manifests/deployment.yml via Jenkins Pipeline'
                            git remote -v
                            git push https://\${GITHUB_TOKEN}@github.com/\${GIT_USER_NAME}/\${GIT_REPO_NAME}.git HEAD:main
                        """
                    }
                }
            }
        }

    }
}
