# outputs.tf

/* output "docker_name" {
  value=docker_container.vault.name
  description = "Docker Container Name"
} */

output "dirname_splunk_config" {
  value = dirname(local_file.splunk-config.filename)
}

output "dirname_splunk_hashi_app" {
  value = dirname(local_file.splunk-hashi-app.filename)
}

output "container_name_vault_s1" {
  value = docker_container.vault_s1.name
}

output "container_ip_vault_s1" {
  value = docker_container.vault_s1.ip_address
}

output "container_name_vault_s2" {
  value = docker_container.vault_s2.name
}

output "container_ip_vault_s2" {
  value = docker_container.vault_s2.ip_address
}

output "container_name_vault_s3" {
  value = docker_container.vault_s3.name
}

output "container_ip_vault_s3" {
  value = docker_container.vault_s3.ip_address
}

output "container_name_vault_fluentd" {
  value = docker_container.fluentd.name
}

output "container_ip_vault_fluentd" {
  value = docker_container.fluentd.ip_address
}

output "container_name_vault_splunk" {
  value = docker_container.splunk.name
}

output "container_ip_vault_splunk" {
  value = docker_container.splunk.ip_address
}

output "container_name_vault_telegraf" {
  value = docker_container.telegraf.name
}

output "container_ip_vault_telegraf" {
  value = docker_container.telegraf.ip_address
}

output "container_network" {
  value = docker_network.vault-ent-network.ipam_config
}
