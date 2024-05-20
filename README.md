# cision-tasks
assessment

# Jenkins CI/CD Pipeline for Nginx Application

This repository contains a Jenkins pipeline configuration for an Nginx application. The pipeline automates the process of code analysis, building a Docker image, performing security scans, and deploying the application to a Kubernetes cluster.

## Table of Contents
- Pre-requisites
- Pipeline Overview
- Jenkins Configuration
- Kubernetes Deployment Configuration
- Running the Pipeline
- Notifications
- Troubleshooting

## Pre-requisites

1. Jenkins Setup:
   - Jenkins must be installed and running.
   - Ensure Jenkins can execute Docker commands (Docker should be installed and Jenkins user should be added to the Docker group).

2. Required Jenkins Plugins:
       a.Docker Pipeline Plugin
       b.Kubernetes Continuous Deploy Plugin
       c.SonarQube Scanner Plugin
       d.Kubernetes CLI plugin
       e.Credentilas Plugin
       f.Pipeline Utility Steps Plugin
       g.Blue Ocean Plugin (optional, for a better UI)

4. External Services:
   - Docker Hub: For storing Docker images.
   - Kubernetes Cluster: For deploying the application.
   - SonarQube: For static code analysis.

5. Credentials Configuration in Jenkins:
   - Docker Hub Credentials: A "Username with password" credential with ID 'dockerhub-credentials-id'.
   - Kubernetes Kubeconfig: A "Secret file" credential with ID `kubeconfig-id`.
   - SonarQube Token: A "Secret text" credential with ID `sonarqube-token-id`.

## Pipeline Overview

The Jenkins pipeline consists of the following stages:

1. Checkout: Clones the repository from GitHub.
2. Code Analysis: Runs static code analysis using SonarQube.
3. Quality Gate: Waits for SonarQube to evaluate the code quality.
4. Build Docker Image: Builds a Docker image using the Dockerfile in the repository.
5. Run Security Checks: Performs security scans using Trivy and Snyk.
6. Push Docker Image: Pushes the Docker image to Docker Hub.
7. Deploy to Kubernetes: Deploys the Docker image to the Kubernetes cluster.

## Jenkins Configuration

Global Tool Configuration
1. Go to Manage Jenkins >> Global Tool Configuration.
2. Add a SonarQube Scanner installation.
3. Add your SonarQube server details in the SonarQube servers section with ID 'sonarqube-server-id'.

Creating the Pipeline Job
1. Create a new Pipeline job in Jenkins.
2. Under "Pipeline", select "Pipeline script from SCM".
3. Configure the repository URL: `https://github.com/venkatesh-6667/cision-tasks.git`.
4. Set the branch to the desired branch.("main")

Docker Hub Integration:
1.Go to Jenkins Dashboard -> Manage Jenkins -> Manage Credentials.
2.Click on (global) under "Stores scoped to Jenkins".
3.Click on Add Credentials and select Username with password.
4.Enter your Docker Hub username and password and give it an ID (e.g., dockerhub-credentials-id).

Kubernetes Cluster Integration:
1.Ensure you have kubectl configured to connect to your Kubernetes cluster.
2.Go to Jenkins Dashboard -> Manage Jenkins -> Manage Credentials.
3.Click on (global) under "Stores scoped to Jenkins".
4.Click on Add Credentials and select Secret file.
5.Upload your Kubernetes cluster's kubeconfig file and give it an ID (e.g., kubeconfig-id).

SonarQube Server Integration:
1.Go to Jenkins Dashboard -> Manage Jenkins -> Configure System.
2.Scroll down to the "SonarQube servers" section.
3.Click on Add SonarQube and enter the following details:
4.Name: A descriptive name for your SonarQube server.
5.Server URL: URL of your SonarQube server.
6.Authentication token: Create an authentication token in SonarQube and paste it here.
Click Save.

##Jenkins Pipeline Script (Jenkinsfile)
  The'Jenkinsfile'is the script that defines the pipeline and should be placed in the root of your repository.

## k8s deployment configuration
Ensure you have a k8s/deployment.yaml file in your repository

## Running the Jenkins file
1.Trigger the Job:
Manually trigger the pipeline job in Jenkins or set up webhooks for automated triggers.
2.Monitor the Pipeline:
Watch the pipeline execution in Jenkins. Each stage should pass successfully if configured correctly.

## Notifications (Optional)
To add Slack or email notifications:
1.Install and configure the Slack or Email plugins in Jenkins.
2.Add notification steps in the post section of the Jenkinsfile:

## Troubleshooting
Pipeline Errors: Check the Jenkins console output for detailed error messages.
Docker Issues: Ensure Docker is running and the Jenkins user has access to Docker.
Kubernetes Issues: Verify the kubeconfig is correct and Jenkins can access the Kubernetes cluster.
SonarQube Issues: Ensure the SonarQube server and token are configured correctly.
