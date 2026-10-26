output "container_name" {
  value = docker_container.nginx.name
}

output "container_id" {
  value = docker_container.nginx.id
}

output "application_url" {
  value = "http://localhost:${var.external_port}"
}
