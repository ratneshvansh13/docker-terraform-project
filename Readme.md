# Terraform Docker Container Deployment

Deploy and manage a Docker container using **Terraform Infrastructure as Code (IaC)**. This project demonstrates how to use Terraform to pull a Docker image, create and configure a container, expose application ports, and manage the container lifecycle through declarative configuration.

The project uses the Nginx web server as an example application and exposes it on port `8080` of the host machine.

## Table of Contents

- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Technologies Used](#technologies-used)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Installation and Setup](#installation-and-setup)
- [Deployment](#deployment)
- [Verification and Testing](#verification-and-testing)
- [Customizing Variables](#customizing-variables)

## Project Overview

Manually creating Docker containers is straightforward, but managing infrastructure through repeatable configurations is an important DevOps practice.

In this project, Terraform automates the following tasks:

- Downloads the required Nginx Docker image.
- Creates a Docker container with a configurable name.
- Maps the container's internal port to a host port.
- Starts the container and makes the web server accessible.
- Exposes useful outputs, including the container ID, name, and application URL.
- Supports infrastructure planning, updates, and destruction through Terraform commands.

### Project Goals

1. Understand Terraform providers and resources.
2. Practice defining input variables and outputs.
3. Learn how to manage Docker resources through Terraform.
4. Implement Infrastructure as Code principles.
5. Understand the Terraform resource lifecycle.

## Architecture

```text
Developer
    |
    | Terraform Commands
    v
Terraform CLI
    |
    | Docker Provider
    v
Docker Engine
    |
    | Pull Image
    v
Nginx Docker Image
    |
    | Create Container
    v
Nginx Container
    |
    | Port Mapping: 8080 -> 80
    v
Host Machine
    |
    v
http://localhost:8080
```

### How It Works

1. Terraform initializes the Docker provider.
2. The provider communicates with the local Docker Engine.
3. Terraform downloads the `nginx:latest` image if necessary.
4. Terraform creates a container named `terraform-nginx`.
5. Host port `8080` is mapped to container port `80`.
6. The Nginx welcome page becomes accessible through the browser.

## Technologies Used

| Technology      | Purpose                                              |
| --------------- | ---------------------------------------------------- |
| Terraform       | Infrastructure provisioning and lifecycle management |
| Docker          | Container runtime                                    |
| Docker Provider | Connects Terraform to Docker                         |
| Nginx           | Web server running inside the container              |
| HCL             | Terraform configuration language                     |
| Linux / Ubuntu  | Host operating system                                |

## Prerequisites

Install the following tools before starting.

### 1. Docker

Verify the installation:

```bash
docker --version
```

Check whether Docker is running:

```bash
docker ps
```

If Docker is installed but stopped, start it on Ubuntu:

```bash
sudo systemctl start docker
```

To start Docker automatically after a reboot:

```bash
sudo systemctl enable docker
```

### 2. Terraform

Verify the installation:

```bash
terraform --version
```

If Terraform is not installed, follow the official [Terraform installation guide](https://developer.hashicorp.com/terraform/install).

### 3. Git (Optional)

```bash
git --version
```

Git can be used to version-control the project and publish it on GitHub.

## Project Structure

```text
terraform-docker/
├── main.tf
├── variables.tf
├── outputs.tf
├── .gitignore
└── README.md
```

| File           | Description                                                 |
| -------------- | ----------------------------------------------------------- |
| `main.tf`      | Defines the Terraform provider, Docker image, and container |
| `variables.tf` | Declares configurable input variables                       |
| `outputs.tf`   | Displays useful deployment information                      |
| `.gitignore`   | Excludes local Terraform state and generated files          |
| `README.md`    | Documents the project and deployment procedure              |

## Installation and Setup

### Step 1: Create the Project Directory

```bash
mkdir terraform-docker
cd terraform-docker
```

Create the configuration files:

```bash
touch main.tf variables.tf outputs.tf .gitignore README.md
```

Add the Terraform configuration to the respective files.

### Step 2: Initialize Terraform

```bash
terraform init
```

This command downloads the required provider and initializes the working directory.

### Step 3: Format the Configuration

```bash
terraform fmt
```

This formats Terraform configuration files consistently.

### Step 4: Validate the Configuration

```bash
terraform validate
```

This checks whether the configuration is syntactically valid and internally consistent.

### Step 5: Review the Execution Plan

```bash
terraform plan
```

Terraform compares the desired configuration with its current state and proposes the required changes. Review the plan before applying it.

## Deployment

Create the Docker image and container:

```bash
terraform apply
```

Review the proposed changes and enter `yes` when prompted.

After successful deployment, the output should include values similar to:

```text
container_name  = "terraform-nginx"
container_id    = "<container-id>"
application_url = "http://localhost:8080"
```

The container ID is generated by Docker and will differ between deployments.

## Verification and Testing

### 1. Check Running Containers

```bash
docker ps
```

Confirm that `terraform-nginx` is running and that the port mapping resembles:

```text
0.0.0.0:8080->80/tcp
```

### 2. Test the Application

```bash
curl http://localhost:8080
```

A successful request should return HTML containing the Nginx welcome page.

You can also open [http://localhost:8080](http://localhost:8080) in your browser.

### 3. Check Container Logs

```bash
docker logs terraform-nginx
```

### 4. Inspect the Container

```bash
docker inspect terraform-nginx
```

### 5. Check Terraform Outputs

```bash
terraform output
```

To display a specific output:

```bash
terraform output application_url
```

### 6. Check Managed Resources

```bash
terraform state list
```

Expected resources:

```text
docker_container.nginx
docker_image.nginx
```

## Customizing Variables

You can override the default values without editing `variables.tf`.

### Example: Change the Container Name and Port

```bash
terraform apply \
  -var="container_name=my-nginx" \
  -var="external_port=9090"
```

The application will then be accessible at [http://localhost:9090](http://localhost:9090).

Terraform will update the existing container as required.

### Using a `terraform.tfvars` File

For multiple custom values, create a `terraform.tfvars` file:

```hcl
container_name = "my-nginx"
image_name     = "nginx:latest"
external_port  = 9090
internal_port  = 80
```

Apply the configuration:

```bash
terraform plan
terraform apply
```

Terraform automatically loads `terraform.tfvars`. Avoid committing this file if it contains sensitive values.
