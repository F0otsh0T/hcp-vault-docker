# variables.tf

variable "path_vault_file" {
  type        = string
  description = "Specify path on local disk to mount Docker Container /vault/file"
  sensitive   = false
  default     = "/var/tmp/volume/vault/file"
}

variable "path_vault_config" {
  type        = string
  description = "Specify path on local disk to mount Docker Container /vault/config"
  sensitive   = false
  default     = "/var/tmp/volume/vault/config"
}

/* variable "path_vault_sensitive_file" {
  type        = string
  description = "Specify path on local disk to mount Docker Container /vault/file - will be created relative to this TF workspace"
  sensitive   = false
  default     = "volume/test/vault-sensitive-file"
} */

variable "docker_tag" {
  type        = string
  description = "Specify the version for your Docker Container"
  sensitive   = false
  default     = "1.9.5"
}

variable "container_name" {
  type        = string
  description = "Specify name for your Docker Container"
  sensitive   = false
  default     = "vault-test"
}

variable "docker_port_internal" {
  type        = number
  description = "Specify Vault Internal Port Number"
  sensitive   = false
  default     = "8200"
}

variable "docker_port_external" {
  type        = number
  description = "Specify Vault External Port Number"
  sensitive   = false
  default     = "8200"
}

variable "docker_restart" {
  type        = string
  description = "Specify Docker Restart Policy"
  sensitive   = false
  default     = "unless-stopped"
  validation {
    condition     = contains(["no", "on-failure", "always", "unless-stopped"], var.docker_restart)
    error_message = "Value must be no, on-failure, always, unless-stopped."
  }
}

variable "vault_root_token" {
  type        = string
  description = "Specify Root Token for your Vault Service"
  sensitive   = true
  default     = "root"
}
