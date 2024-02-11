jenkins:
    systemMessage: "Jenkins ECS Fargate"
    numExecutors: 0
    remotingSecurity:
      enabled: true
    agentProtocols:
        - "JNLP4-connect"
    securityRealm:
        local:
            allowsSignup: false
            users:
                - id: ecsuser
                  password: \$${ADMIN_PWD}
    authorizationStrategy:
        globalMatrix:
            grantedPermissions:
                - "Overall/Read:authenticated"
                - "Job/Read:authenticated"
                - "View/Read:authenticated"
                - "Overall/Administer:authenticated"
    crumbIssuer: "standard"
    slaveAgentPort: 50000
    clouds:
        - ecs:
              numExecutors: 1
              allowedOverrides: "inheritFrom,label,memory,cpu,image"
              credentialsId: ""
              cluster: ${ecs_cluster_fargate_spot}
              name: "fargate-spot"
              regionName: ${cluster_region}
              retentionTimeout: 10
              jenkinsUrl: "http://${jenkins_cloud_map_name}:${jenkins_controller_port}"
              templates:
                  - cpu: "512"
                    image: "jenkins/inbound-agent:latest"
                    label: "jenkins-agent-spot"
                    executionRole: ${execution_role_arn}
                    launchType: "FARGATE"
                    memory: 0
                    memoryReservation: 1024
                    networkMode: "awsvpc"
                    privileged: false
                    remoteFSRoot: "/home/jenkins"
                    securityGroups: ${agent_security_groups}
                    sharedMemorySize: 0
                    subnets: ${subnets}
                    templateName: "jenkins-agent-spot"
                    uniqueRemoteFSRoot: false
        - ecs:
              numExecutors: 1
              allowedOverrides: "inheritFrom,label,memory,cpu,image"
              credentialsId: ""
              cluster: ${ecs_cluster_fargate}
              name: "fargate-main"
              regionName: ${cluster_region}
              retentionTimeout: 10
              jenkinsUrl: "http://${jenkins_cloud_map_name}:${jenkins_controller_port}"
              templates:
                  - cpu: "512"
                    image: "jenkins/inbound-agent:latest"
                    label: "jenkins-agent-main"
                    executionRole: ${execution_role_arn}
                    launchType: "FARGATE"
                    memory: 0
                    memoryReservation: 1024
                    networkMode: "awsvpc"
                    privileged: false
                    remoteFSRoot: "/home/jenkins"
                    securityGroups: ${agent_security_groups}
                    sharedMemorySize: 0
                    subnets: ${subnets}
                    templateName: "build-example"
                    uniqueRemoteFSRoot: false
security:
  sSHD:
    port: -1

jobs:
  - script: >
      pipelineJob('Demo Pipeline ECS Main') {
        definition {
          cps {
            script('''
              pipeline {
                  agent {
                      ecs {
                          inheritFrom 'jenkins-agent-main'
                      }
                  }
                  stages {
			  stage('Build') {
                        steps {
                            script {
                                sh "echo this was executed on a spot instance"
                            }
                            sh '''
                                terraform version
                            '''
                            sh 'sleep 5'
                            sh 'echo sleep is done'
                        }
                    }
                    stage('Test') {
                        steps {
                            script {
                                sh "echo this was executed on a spot instance"
                            }
                            sh '''
                                terraform version
                            '''
                            sh 'sleep 5'
                            sh 'echo sleep is done'
                        }
                    }
                    stage('Deploy') {
                        steps {
                            script {
                                sh "echo this was executed on a spot instance"
                            }
                            sh '''
                                terraform version
                            '''
                            sh 'sleep 5'
                            sh 'echo sleep is done'
                        }
                    }
                        }

                    }
                  }
              }'''.stripIndent())
              sandbox()
          }
        }
      }
  - script: >
      pipelineJob('Demo Pipeline ECS Spot') {
        definition {
          cps {
            script('''
              pipeline {
                  agent {
                      ecs {
                          inheritFrom 'jenkins-agent-spot'
                      }
                  }
                  stages {
                    stage('Test') {
                        steps {
                            script {
                                sh "echo this was executed on a spot instance"
                            }
                            sh 'sleep 120'
                            sh 'echo sleep is done'
                        }
                    }
                  }
              }'''.stripIndent())
              sandbox()
          }
        }
      }
