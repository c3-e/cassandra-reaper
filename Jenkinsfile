@Library('c3')
import io.c3.*

timestamps {
   timeout(time: 1, unit: 'HOURS') {
      withCredentials([usernamePassword(credentialsId: 'devops-c3ci', usernameVariable: 'GITHUB_USERNAME', passwordVariable: 'GITHUB_TOKEN')]) {
         node('buildah') {
            //TODO: Automate release process
            def buildNumber = "1"

            stage("Build") {
               checkout(scm).GIT_COMMIT
               sh "./gradlew build -PreleaseVersion=${buildNumber}"
            }

            stage("Pre-Release") {
               sh "./gradlew pre_release -PreleaseVersion=${buildNumber}"
            }

            /*
            stage("Test") {
               sh "./gradlew test -PreleaseVersion=${buildNumber}"
            }

            stage("Release") {
               sh "./gradlew release -PreleaseVersion=${buildNumber}"
            }
            */
         }
      }
   }
}
