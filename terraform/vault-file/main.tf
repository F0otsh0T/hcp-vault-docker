# main.tf

################################################

resource "null_resource" "cleanup" {
  provisioner "local-exec" {
    #    command = "rm -rf ${var.path_vault_config}"
    command = "mv ${var.path_vault_config} /tmp"
  }
  provisioner "local-exec" {
    #    command = "rm -rf ${var.path_vault_file}"
    command = "mv ${var.path_vault_file} /tmp"
  }
}

################################################

provider "local" {
  # Configuration options
}

resource "local_file" "vault-config" {
  depends_on = [
    null_resource.cleanup
  ]
  source          = "${path.root}/config.json"
  filename        = "${var.path_vault_config}/config.json"
  file_permission = "0644"
  provisioner "local-exec" {
    when = destroy
    command = "mv ${dirname(self.filename)} /tmp"
  }
}

resource "local_file" "vault-file" {
  depends_on = [
    null_resource.cleanup
  ]
  content = "foobar"
  filename        = "${var.path_vault_file}/foo.bar"
  file_permission = "0600"
  provisioner "local-exec" {
    when = destroy
    command = "mv ${dirname(self.filename)} /tmp"
  }
}

/* resource "local_sensitive_file" "vault-sensitive-file" {
  content  = "bar!"
#  filename = "${path.module}/bar"
  filename = "${var.path_vault_sensitive_file}/bar"
} */

################################################

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
    "server"
    #    "server",
    #    "-dev",
    #    "-dev-root-token-id=${var.vault_root_token}"
  ]
  volumes {
    host_path      = dirname(local_file.vault-config.filename)
    container_path = "/vault/config"
    #    volume_name = "vault-config"
  }
  volumes {
    host_path      = dirname(local_file.vault-file.filename)
    container_path = "/vault/file"
    #    volume_name = "vault-file"
  }
}




