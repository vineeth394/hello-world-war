pipeline {
    agent any

    environment {
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64'
        MAVEN_HOME = '/usr/share/maven'
        PATH = "${JAVA_HOME}/bin:${MAVEN_HOME}/bin:${env.PATH}"
       # DOCKER_IMAGE = "vineeth394/my_ubuntu_images:latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }

        stage('Build') {
            steps { 
                echo "Building the package..."
                sh 'docker --version'
                sh 'docker build -t tomcat .'
            }
        }

         stage('Login to Docker Hub') {
            steps {
                echo 'Logging into Docker Hub...'
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                }
            }
        }
        
        stage('Upload Artifact') {
            steps {
                echo 'Uploading to Docker Hub...'
                sh 'docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}'
                sh 'docker push ${DOCKER_USER}/my_ubuntu_images:latest'
            }
        }

        stage('Container') {
            steps { 
                echo "Running the image to create a container..."
                sh 'docker run -d -p 8085:8080 tomcat'
            }
        }
    }
}
