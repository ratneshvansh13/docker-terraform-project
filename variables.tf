variable "container_name" {
  description = "Name of the Docker container"
  type        = string
  default     = "terraform-nginx"
}

variable "image_name" {
  description = "Docker image to use"
  type        = string
  default     = "nginx:latest"
}

variable "external_port" {
  description = "Host port to access Nginx"
  type        = number
  default     = 8080
}

variable "internal_port" {
  description = "Port exposed inside the container"
  type        = number
  default     = 80
}
