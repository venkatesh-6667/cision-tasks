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
       - Docker Pipeline Plugin
       - Kubernetes Continuous Deploy Plugin
       - SonarQube Scanner Plugin
       - Kubernetes CLI plugin
       - Credentilas Plugin
       - Pipeline Utility Steps Plugin
       - Blue Ocean Plugin (optional, for a better UI)

4. External Services:
   - Docker Hub: For storing Docker images.
   - Kubernetes Cluster: For deploying the application.
   - SonarQube: For static code analysis.

5. Credentials Configuration in Jenkins:
   - Docker Hub Credentials: A "Username with password" credential with ID `dockerhub-credentials-id`.
   - Kubernetes Kubeconfig: A "Secret file" credential with ID `kubeconfig-id`.
   - SonarQube Token: A "Secret text" credential with ID `sonarqube-token-id`.

## Pipeline Overview

The Jenkins pipeline consists of the following stages:

- Checkout: Clones the repository from GitHub.
- Code Analysis: Runs static code analysis using SonarQube.
- Quality Gate: Waits for SonarQube to evaluate the code quality.
- Build Docker Image: Builds a Docker image using the Dockerfile in the repository.
- Run Security Checks: Performs security scans using Trivy and Snyk.
- Push Docker Image: Pushes the Docker image to Docker Hub.
- Deploy to Kubernetes: Deploys the Docker image to the Kubernetes cluster.

## Jenkins Configuration

Global Tool Configuration
- Go to Manage Jenkins >> Global Tool Configuration.
- Add a SonarQube Scanner installation.
- Add your SonarQube server details in the SonarQube servers section with ID `sonarqube-server-id`.

Creating the Pipeline Job
- Create a new Pipeline job in Jenkins.
- Under "Pipeline", select "Pipeline script from SCM".
- Configure the repository URL: `https://github.com/venkatesh-6667/cision-tasks.git`.
- Set the branch to the desired branch.("main")

Docker Hub Integration:
- Go to Jenkins Dashboard -> Manage Jenkins -> Manage Credentials.
- Click on (global) under "Stores scoped to Jenkins".
- Click on Add Credentials and select Username with password.
- Enter your Docker Hub username and password and give it an ID (e.g., dockerhub-credentials-id).

Kubernetes Cluster Integration:
- Ensure you have kubectl configured to connect to your Kubernetes cluster.
- Go to Jenkins Dashboard -> Manage Jenkins -> Manage Credentials.
- Click on (global) under "Stores scoped to Jenkins".
- Click on Add Credentials and select Secret file.
- Upload your Kubernetes cluster's kubeconfig file and give it an ID (e.g., kubeconfig-id).

SonarQube Server Integration:
- Go to Jenkins Dashboard -> Manage Jenkins -> Configure System.
- Scroll down to the "SonarQube servers" section.
- Click on Add SonarQube and enter the following details:
- Name: A descriptive name for your SonarQube server.
- Server URL: URL of your SonarQube server.
- Authentication token: Create an authentication token in SonarQube and paste it here.
  Click Save.

##Jenkins Pipeline Script (Jenkinsfile)
  The'Jenkinsfile'is the script that defines the pipeline and should be placed in the root of your repository.

## k8s deployment configuration
Ensure you have a `k8s/deployment.yaml` file in your repository

## Running the Jenkins file
- Trigger the Job:
  Manually trigger the pipeline job in Jenkins or set up webhooks for automated triggers.
- Monitor the Pipeline:
  Watch the pipeline execution in Jenkins. Each stage should pass successfully if configured correctly.

## Notifications (Optional)
To add Slack or email notifications:
- Install and configure the Slack or Email plugins in Jenkins.
- Add notification steps in the post section of the Jenkinsfile:

## Troubleshooting
Pipeline Errors: Check the Jenkins console output for detailed error messages.
Docker Issues: Ensure Docker is running and the Jenkins user has access to Docker.
Kubernetes Issues: Verify the kubeconfig is correct and Jenkins can access the Kubernetes cluster.
SonarQube Issues: Ensure the SonarQube server and token are configured correctly.
