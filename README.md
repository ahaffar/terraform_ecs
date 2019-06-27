---
description: ECS with load-balanced simple Web App
Tools: AWS, Terraform
---

# OVERVIEW
This LAB represents an AWS Elastic Container Services enviroment - i have created this repo while learning / working on my first task in AWS cloud.  
below is a HLD represents the deployment


## HLD - High Level Diagram

<p align="center">
  <img width="800" height="1024" src="https://github.com/ahaffar/terraform_ecs/blob/master/AWS%20ECS.png">
</p>

# TASKS
 - [x] Create the required variables file, this file include all the hard-coded values used in the entire project
 - [x] Create A VPC: this VPC include - IGW , NAT GW, Private Subnet, Security Groups, Public Subnet and thier associated routes
 - [x] Create the required IAM roles and service-linked roles
 - [x] Create the AWS Launch configuration and the associated AutoScalingGroups
 - [x] Define the Task Defention
 - [x] Create the Service and ALB - Application Load Balancer
    * <public dns_name>:8088 - listening on the Flask web server
    * <public dns_name> - listening on the nginx server
 - [x] Create Managment server hosted on public subnet in order to manage the internal container instances

# HOW TO USE
 * **DONT** use the root user, its recommended to explore the IAM roles and delegate the specific needed roles to a new user account
 * you can store the AWS_SECRET_ACCESS_KEY and AWS_ACCESS_KEY_ID as Terraform variables! but i stored the required credentials in `~/.bashrc` file
 ```bash
export AWS_SECRET_ACCESS_KEY=""
export AWS_ACCESS_KEY_ID=""
alias tf='terraform' # for more easy use
```
 * Clone this repo 
```bash
git clone https://github.com/ahaffar/terraform_ecs.git
cd terraform-ecs
```
 * Change the required values in aws_variables.tf file to reflect your specific settings such as `SSH_KEY`, `CLUSTER_NAME` .. 
 * RUN `terraform plan` to check the config
 * RUN `terraform apply`
 * Enjoy!
