<p align="center">
    <a href="https://cloud.ibm.com">
        <img src="https://cloud.ibm.com/media/docs/developer-appservice/resources/ibm-cloud.svg" height="100" alt="IBM Cloud">
    </a>
</p>

<p align="center">
    <a href="https://cloud.ibm.com">
    <img src="https://img.shields.io/badge/IBM%20Cloud-powered-blue.svg" alt="IBM Cloud">
    </a>
    <img src="https://img.shields.io/badge/platform-node-lightgrey.svg?style=flat" alt="platform">
    <img src="https://img.shields.io/badge/license-Apache2-blue.svg?style=flat" alt="Apache 2">
</p>


# Deploy Springboot Application on IBM Cloud using Terraform

This document will describe how to deploy Springboot application on IBM Cloud Kubernetes Service using Terraform (IaC Tool).

### Contents

#### 1.     Introduction
#### 2.     Pre-requisites
#### 3.     Deploying to IBM Cloud using Terraform
#### 3.1	    To an existing Kubernetes cluster with Tekton Toolchain pipeline


### 1.0 Introduction

To complete this tutorial, you should have an IBM Cloud account, if you do not have one, please [register/signup](https://cloud.ibm.com/registration) here. This application requires the Kubernetes cluster for running Springboot application.

**Note:** You can perform this job either using free cluster or standard cluster, in this tutorial it is done using free cluster.

### 2.0 Pre-requisites

To deploy Springboot application on IBM Cloud Kubernetes service using Terraform, you should have the following software installed on your system.

  -	Terraform
  -	IBM Cloud CLI
  -	Kubectl
  - jq
  
Note: This repo include the terraform code to deploy the application to an existing Kubernetes Cluster, therefor you should have a IBM IKS cluster ready and do not forget to replace the variable value for the cluster name in the variables.tf file with your existing cluster name. 

### 3.0	Deploying to IBM Cloud using Terraform 

<p align="center">
    <a href="https://cloud.ibm.com/developer/appservice/create-app?defaultDeploymentToolchain=&defaultLanguage=NODE&navMode=starterkits&starterKit=3f3f65c6-4a2c-3255-8e80-d2ac52ca608a">
    <img src="https://cloud.ibm.com/devops/setup/deploy/button_x2.png" alt="Deploy to IBM Cloud">
    </a>
</p>

To start deploying, clone the repo to local machine using the following command and follow the instructions in next section as per the scenario available.

```bash
git clone https://github.com/marifse/springboot-ibmcloud
```

### 3.1. To an Existing Kubernetes cluster with Tekton Toolchain pipeline

To deploy Springboot application to a existing Kubernetes cluster, clone the repo as mentioned in above step 3.0, and follow the steps below. 

•	Go into sub-directory (springboot-ibmcloud/terraform) of cloned repo with below command.

```bash
cd springboot-ibmcloud/Terraform/
```

•	Replace the API Key(**ibmcloud_api_key**)  with your key and the Cluster Name(**ibmcloud_api_key**) with your created cluster name in variables.tf file.

•	Initialize the repo with below command.

```bash
terraform init
```

•	Deploy Springboot application with below terraform command.

```bash
terraform apply
```

• Confirm with “yes”.

This terraform script will provision the Tekton toolchain, which is auto triggered on its creation and deploying the application to the existing IKS Kubernetes cluster.

To get the URL for deployed application, go to Toolchain service in IBM Cloud console, and select the region where the toolchain has been created and go to triggered event, and there in deployment stage, you can find the application URL as IPAddress:port in last lines of the executions. Open that URL in browser and you can see the Springboot application deployed there.

•	To destroy the deployment run below terraform command.

```bash
terraform destroy
```
