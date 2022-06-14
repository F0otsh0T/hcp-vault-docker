# main.tf

provider "docker" {
  # Configuration options
}

resource "docker_image" "vault" {
  name         = "vault:${var.docker_tag}"
  keep_locally = false
}

resource "docker_container" "vault" {
  image = docker_image.vault.latest
  name  = var.container_name
  ports {
    internal = var.docker_port_internal
    external = var.docker_port_external
  }
  restart = var.docker_restart
  capabilities {
    add = ["IPC_LOCK"]
  }
  env = [
#    "VAULT_DEV_LISTEN_ADDRESS=0.0.0.0:${var.docker_port_internal}",
#    "VAULT_DEV_ROOT_TOKEN_ID=root"
  ]
  command = [
    "server",
    "-dev",
    "-dev-root-token-id=${var.vault_root_token}"
  ]
}






