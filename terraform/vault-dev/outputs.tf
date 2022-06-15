# outputs.tf

output "docker_name" {
  value       = docker_container.vault.name
  description = "Docker Container Name"
}







