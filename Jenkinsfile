pipeline {
  agent {
    
  stages {
    stage('Build image') {
      steps {
        sh 'docker build -t my-wordpress-image:$BUILD_NUMBER .'
      }
    }
    
    stage('Push image to Docker registry') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerb', passwordVariable: 'p2ace0fm1nd!', usernameVariable: 'lkasd7512')]) {
          sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
        }
        
        sh 'docker push my-wordpress-image:$BUILD_NUMBER'
      }
    }
    
    stage('Update deployment') {
      steps {
        script {
          def label = "app=wordpress"
          def wp_pod = sh(script: "kubectl get pods -l $label -o jsonpath='{.items[0].metadata.name}'", returnStdout: true).trim()
          
          sh "kubectl cp index.php ${wp_pod}:/var/www/html/index.php"
          
          sh "kubectl set image deployment/wordpress wordpress=my-wordpress-image:$BUILD_NUMBER"
        }
      }
    }
  }
}
