# variables.tf

variable "path_splunk_hashi_app" {
  type        = string
  description = "Specify path on local disk to mount Splunk Container /tmp/<name of Splunk HashiCorp Vault App>"
  sensitive   = false
  default     = "/var/tmp/volume/vault-ent/splunk/tmp"
}

variable "splunk_hashi_app" {
  type        = string
  description = "Specify HashiCorp Vault Splunk App Package"
  sensitive   = false
  default     = "hashicorp-vault-app-for-splunk_103.tgz"
}

variable "path_splunk_config" {
  type        = string
  description = "Specify path on local disk to mount Splunk Container /tmp/defaults"
  sensitive   = false
  default     = "/var/tmp/volume/vault-ent/splunk/tmp/defaults"
}

variable "path_telegraf_config" {
  type        = string
  description = "Specify path on local disk to mount Telegraf Container /etc/telegraf"
  sensitive   = false
  default     = "/var/tmp/volume/vault-ent/telegraf/etc/telegraf"
}

variable "path_fluent_config" {
  type        = string
  description = "Specify path on local disk to mount FluentD Container /fluentd/etc"
  sensitive   = false
  default     = "/var/tmp/volume/vault-ent/fluent/etc"
}

variable "path_vault_s1_config" {
  type        = string
  description = "Specify path on local disk to mount Vault Container /vault/config"
  sensitive   = false
  default     = "/var/tmp/volume/vault-ent/vault_s1/config"
}

variable "path_vault_s1_data" {
  type        = string
  description = "Specify path on local disk to mount Vault Container /vault/data"
  sensitive   = false
  default     = "/var/tmp/volume/vault-ent/vault_s1/data"
}

variable "path_vault_s2_config" {
  type        = string
  description = "Specify path on local disk to mount Vault Container /vault/config"
  sensitive   = false
  default     = "/var/tmp/volume/vault-ent/vault_s2/config"
}

variable "path_vault_s2_data" {
  type        = string
  description = "Specify path on local disk to mount Vault Container /vault/data"
  sensitive   = false
  default     = "/var/tmp/volume/vault-ent/vault_s2/data"
}

variable "path_vault_s3_config" {
  type        = string
  description = "Specify path on local disk to mount Vault Container /vault/config"
  sensitive   = false
  default     = "/var/tmp/volume/vault-ent/vault_s3/config"
}

variable "path_vault_s3_data" {
  type        = string
  description = "Specify path on local disk to mount Vault Container /vault/data"
  sensitive   = false
  default     = "/var/tmp/volume/vault-ent/vault_s3/data"
}

#variable "path_vault_data" {
#  type        = string
#  description = "Specify path on local disk to mount Vault Container /vault/data"
#  sensitive   = false
#  default     = "/var/tmp/volume/vault-ent/data"
#}

variable "path_vault_log" {
  type        = string
  description = "Specify path on local disk to mount **SHARED** Vault Container /var/log/vault"
  sensitive   = false
  default     = "/var/tmp/volume/vault-ent/log"
}

/* variable "path_vault_sensitive_file" {
  type        = string
  description = "Specify path on local disk to mount Docker Container /vault/file - will be created relative to this TF workspace"
  sensitive   = false
  default     = "volume/test/vault-sensitive-file"
} */

variable "container_image_vault" {
  type        = string
  description = "Specify the image for your Vault Container"
  sensitive   = false
  /* default     = "hashicorp/vault" */
  default = "hashicorp/vault-enterprise"
}

variable "container_tag_vault" {
  type        = string
  description = "Specify the version or tag for your Vault Container"
  sensitive   = false
  #default     = "1.9.5"
  #default = "1.9.5-ent"
  #default = "1.11.0-ent"
  #default = "1.12.2-ent"
  default = "1.14.1-ent"
}

variable "container_name_vault_s1" {
  type        = string
  description = "Specify name for your Vault Container"
  sensitive   = false
  default     = "vault_s1"
}

variable "container_name_vault_s2" {
  type        = string
  description = "Specify name for your Vault Container"
  sensitive   = false
  default     = "vault_s2"
}

variable "container_name_vault_s3" {
  type        = string
  description = "Specify name for your Vault Container"
  sensitive   = false
  default     = "vault_s3"
}

variable "container_image_fluentd" {
  type        = string
  description = "Specify the image for your FluentD Container"
  sensitive   = false
  default     = "fluentd"
}

variable "container_tag_fluentd" {
  type        = string
  description = "Specify the version or tag for your FluentD Container"
  sensitive   = false
  default     = "v1.14-1"
  /* sha256:9624d5acdaf03449120293a1f5332154dc9c2796fddf4b1f998aeee5aaca7027 */
  /* default     = "latest" */
}

variable "container_name_fluentd" {
  type        = string
  description = "Specify name for your FluentD Docker Container"
  sensitive   = false
  default     = "vault-fluentd"
}

variable "container_image_splunk" {
  type        = string
  description = "Specify the image for your Splunk Container"
  sensitive   = false
  #default     = "arm64v8/splunk"
  default     = "splunk/splunk"
  #default     = "odidev/docker-splunk"
}

variable "container_tag_splunk" {
  type        = string
  description = "Specify the version or tag for your Splunk Container"
  sensitive   = false
  default     = "9.0.0"
  #sha256:adcdf7ae7dc8033b14122404c900361d46a27ec6cf98dcf6e627ecf07fd84c0e
  #default     = "latest"
  #default     = "splunk-debian-10"
}

variable "container_name_splunk" {
  type        = string
  description = "Specify name for your Splunk Docker Container"
  sensitive   = false
  default     = "vault-splunk"
}

variable "container_image_telegraf" {
  type        = string
  description = "Specify the image for your Telegraf Container"
  sensitive   = false
  default     = "telegraf"
}

variable "container_tag_telegraf" {
  type        = string
  description = "Specify the version or tag for your Telegraf Container"
  sensitive   = false
  default     = "1.23"
  /* sha256:e3eef6a27482a8e8a1f1bd718e9b1cc819340e52f849a1dc93783757f6580ac6 */
  /* default     = "latest" */
}

variable "container_name_telegraf" {
  type        = string
  description = "Specify name for your Telegraf Docker Container"
  sensitive   = false
  default     = "vault-telegraf"
}

variable "docker_port_internal_vault" {
  type        = number
  description = "Specify Vault Internal Port Number"
  sensitive   = false
  default     = "8200"
}

variable "docker_port_external_vault_s1" {
  type        = number
  description = "Specify Vault S1 External Port Number"
  sensitive   = false
  default     = "18200"
}

variable "docker_port_external_vault_s2" {
  type        = number
  description = "Specify Vault S2 External Port Number"
  sensitive   = false
  default     = "28200"
}

variable "docker_port_external_vault_s3" {
  type        = number
  description = "Specify Vault S3 External Port Number"
  sensitive   = false
  default     = "38200"
}

variable "docker_port_internal_fluentd" {
  type        = number
  description = "Specify FluentD Internal Port Number"
  sensitive   = false
  default     = "24224"
}

variable "docker_port_external_fluentd" {
  type        = number
  description = "Specify FluentD External Port Number"
  sensitive   = false
  default     = "24224"
}

variable "docker_protocol_fluentd" {
  type        = string
  description = "Specify FluentD Protocol"
  sensitive   = false
  default     = "udp"
  validation {
    condition     = contains(["tcp", "udp", "sctp"], var.docker_protocol_fluentd)
    error_message = "Value must be tcp, udp, sctp."
  }
}

variable "docker_port_internal_splunk" {
  type        = number
  description = "Specify Splunk Internal Port Number"
  sensitive   = false
  default     = "8000"
}

variable "docker_port_external_splunk" {
  type        = number
  description = "Specify Splunk External Port Number"
  sensitive   = false
  default     = "8000"
}

variable "docker_port_internal_telegraf" {
  type        = number
  description = "Specify Telegraf Internal Port Number"
  sensitive   = false
  default     = "8125"
}

variable "docker_port_external_telegraf" {
  type        = number
  description = "Specify Telegraf External Port Number"
  sensitive   = false
  default     = "8125"
}

variable "docker_protocol_telegraf" {
  type        = string
  description = "Specify Telegraf Protocol"
  sensitive   = false
  default     = "udp"
  validation {
    condition     = contains(["tcp", "udp", "sctp"], var.docker_protocol_telegraf)
    error_message = "Value must be tcp, udp, sctp."
  }
}

variable "docker_restart_vault" {
  type        = string
  description = "Specify Vault Docker Restart Policy"
  sensitive   = false
  default     = "unless-stopped"
  validation {
    condition     = contains(["no", "on-failure", "always", "unless-stopped"], var.docker_restart_vault)
    error_message = "Value must be no, on-failure, always, unless-stopped."
  }
}

variable "docker_restart_splunk" {
  type        = string
  description = "Specify Splunk Docker Restart Policy"
  sensitive   = false
  default     = "always"
  validation {
    condition     = contains(["no", "on-failure", "always", "unless-stopped"], var.docker_restart_splunk)
    error_message = "Value must be no, on-failure, always, unless-stopped."
  }
}

variable "docker_restart_telegraf" {
  type        = string
  description = "Specify Telegraf Docker Restart Policy"
  sensitive   = false
  default     = "always"
  validation {
    condition     = contains(["no", "on-failure", "always", "unless-stopped"], var.docker_restart_telegraf)
    error_message = "Value must be no, on-failure, always, unless-stopped."
  }
}

variable "vault_root_token" {
  type        = string
  description = "Specify Root Token for your Vault Service"
  sensitive   = true
  default     = "root"
}
