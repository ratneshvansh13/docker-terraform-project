# Check Docker is installed and running

docker --version
docker ps

# Initialize Terraform and download the provider

terraform init

# Validate the configuration

terraform validate

# Preview the resources Terraform will create

terraform plan

# Create the Docker image and container

terraform apply
