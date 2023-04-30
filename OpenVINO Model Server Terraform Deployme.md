OpenVINO Model Server Terraform Deployment on Kubernetes 
Task Introduction 
We would like you to create a GitHub repository that contains a Terraform configuration to deploy an instance of the OpenVINO Model Server on a Kubernetes cluster. The deployment should be easily reproducible and contain all necessary resources to run the server. You can choose to deploy on either Amazon EKS, Azure AKS, or Google GKE.  

Task Description:
Create a GitHub repository for this task. You can name the repository "openvino-model-server-k8s-terraform".  
Set up the necessary Terraform configuration files to create a Kubernetes cluster on the cloud provider of your choice (Amazon EKS, Azure AKS, or Google GKE). Ensure that the configuration includes the required resources such as VPC, subnets, and any other necessary components.  

Create a Terraform configuration to deploy the OpenVINO Model Server on the Kubernetes cluster. This should include: 

a. A Kubernetes deployment that defines the OpenVINO Model Server container, including the necessary environment variables, volume mounts, and resources. 

b. A Kubernetes service to expose the OpenVINO Model Server to the internet or within the cluster, depending on your preference. 
You can choose between a LoadBalancer, NodePort, or ClusterIP service type. c. If required, a Kubernetes ConfigMap or Secret to store any sensitive information or configuration files for the OpenVINO Model Server.  

Write a README.md file for the GitHub repository that includes the following information: 
a. A brief introduction to the OpenVINO Model Server and the purpose of the repository. 
b. Prerequisites for using the Terraform configurations, such as required software, cloud provider account, and necessary permissions. c. Step-by-step instructions 


FLOWS:
-----
1. Created a repo called : openvino-model-server-k8s-terraform and created a dev branch which is updated to be the default branch.

2. Clone the repository using HTTPS.
   https://github.com/puzuwe/openvino-model-server-k8s-terraform.git

3. cd to openvino-model-server-k8s-terraform and checkout dev and pull latest.

4. Sure, here is a step-by-step guide on how to create an OpenVINO Model Server using Terraform Deployment on Kubernetes using Amazon EKS:

Prerequisites:

Before we begin, make sure you have the following tools and credentials available:

    An AWS account
    AWS CLI
    Terraform
    Kubectl
    A Kubernetes cluster on Amazon EKS
    Docker

-- terraform init, validate, plan, apply

-- add .gitignore

