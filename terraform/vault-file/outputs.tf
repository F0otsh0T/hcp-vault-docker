# outputs.tf

/* output "docker_name" {
  value=docker_container.vault.name
  description = "Docker Container Name"
} */

output "dirname_vault_config" {
  value=dirname(local_file.vault-config.filename)
}

output "dirname_vault_file" {
  value=dirname(local_file.vault-file.filename)
}



