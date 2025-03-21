pipeline {
    agent any

    environment {
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64'
        MAVEN_HOME = '/usr/share/maven'
        PATH = "${JAVA_HOME}/bin:${MAVEN_HOME}/bin:${env.PATH}"
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

        stage('Upload Artifact') {
            steps {
                echo 'Uploading to Docker Hub...'
                sh 'docker login -u ${username_docker} -p ${dockerid}'
                sh 'docker push ${username_docker}/my_ubuntu_images:latest'
            }
        }

        stage('Container') {
            steps { 
                echo "Running the image to create a container..."
                sh 'docker run -d -p 8085:8080 tomcat'
            }
        }
    }

    post {
        success {
            echo "Build success"
            sh 'echo "Build Accomplished" | mail -s "Build Success" vineethmuntamadugu@gmail.com'
        }
    }
}
