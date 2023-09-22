pipeline {
    stages {
        stage('Build') {
            agent {
                dockerfile {
                    filename 'Dockerfile.build'
                }
            }
            steps {
                sh 'build-app'
            }
        }
        stage('Test') {
            agent {
                dockerfile {
                    filename 'Dockerfile.build'
                }
            }
            steps {
                sh 'test-app'
            }
            post {
                always {
                    junit '**/target/surefire-reports/TEST-*.xml'
                }
            }
        }
        stage('Analyze') {
            agent {
                dockerfile {
                    filename 'Dockerfile.build'
                }
            }
            when {
                branch 'develop'
            }
            steps {
                script {
                    analyze().
                        commentingAfterwards() {
                            withSonarQubeEnv('SonarQube') {
                                sh 'analyze-app'
                            }
                        }
                }
            }
        }
        stage("Quality Gate") {
            steps {
                waitForQualityGate abortPipeline: true
            }
        }
        stage('Deploy') {
            agent {
                dockerfile {
                    filename 'Dockerfile.deploy'
                }
            }
            steps {
                script {
                    shell withMaven: 'deploy-app'
                }
            }
        }
    }
}

