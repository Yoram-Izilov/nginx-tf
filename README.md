# NGINX Deployment on AWS with Terraform - Overview
This project demonstrates the deployment of an NGINX web server on AWS infrastructure using Terraform, Docker, and AWS resources.<br/>
Upon deployment, the NGINX server responds with the text "yo this is nginx" when accessed from a browser.<br/>
You can access it with the Load Balancer DNS that was created.

# Features
- Infrastructure as Code: Automated infrastructure provisioning with Terraform.
- Dockerized NGINX: Containerized NGINX server configured for custom response.
- Secure Architecture: VPC with public and private subnets ensuring secure access.
- Seamless Deployment: terraform apply automates resource creation and deployment.
- AWS Resources:
  - VPC with Public and Private Subnets
  - Internet Gateway and NAT Gateway
  - EC2 Instance with Docker
  - Security Groups for controlled access
  - Load balancer to access the private instance

# Github Actions
- I have the following keys in git secrets:
  - AWS_SANDBOX (aws-access-key-id)
  - AWS_SECRET (aws-secret-access-key)
  - DOCKER_HUB_TOKEN
- The 'terraform.yml' build and push the docker image to docker hub, and create an AWS envoirment in us-east-1

## Instructions for cloning the repository
- Make sure to change in the 'terraform.yml' docker username and image_name to yours
- In '3 - nginx.tf' change - nerdfromhell/yo-nginx to your own docker image name

### Credits - Yoram Izilov
