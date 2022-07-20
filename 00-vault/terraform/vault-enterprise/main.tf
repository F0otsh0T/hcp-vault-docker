# main.tf

################################################
# CONTAINERS
################################################

################################################
# SPLUNK CONTAINER

resource "docker_image" "splunk" {
  name = "${var.container_image_splunk}:${var.container_tag_splunk}"
  #build {
  #  path = "data/splunk/build"
  #  path = "data/splunk/atunnecliffe"
  /* tag  = [
      "${var.container_image_splunk}:${var.container_tag_fluentd}",
      "${var.container_image_splunk}:latest"
      ] */
  #}
  keep_locally = true
}

resource "docker_container" "splunk" {
  depends_on = [
    docker_network.vault-ent-network
  ]
  image      = docker_image.splunk.latest
  name       = var.container_name_splunk
  privileged = true
  networks_advanced {
    name = docker_network.vault-ent-network.name
  }
  ports {
    internal = var.docker_port_internal_splunk
    external = var.docker_port_external_splunk
  }
  restart = var.docker_restart_splunk
  /*   command = [
  ] */
  env = [
    "SPLUNK_START_ARGS=--accept-license",
    "SPLUNK_APPS_URL=/tmp/hashicorp-vault-app-for-splunk_103.tgz"
  ]
  volumes {
    host_path      = dirname(local_file.splunk-hashi-app.filename)
    container_path = "/tmp"
    #    volume_name = "vault-ent-splunk-app"
  }
  volumes {
    host_path      = dirname(local_file.splunk-config.filename)
    container_path = "/tmp/defaults"
    #    volume_name = "vault-ent-splunk-hashi-config"
  }
}

################################################
# FLUENTD CONTAINER

resource "docker_image" "fluentd" {
  name = "${var.container_image_fluentd}/vault:${var.container_tag_fluentd}"
  build {
    path = "data/fluentd"
    /* tag  = ["fluentd/vault:${var.container_tag_fluentd}"] */
  }
  keep_locally = true
}

resource "docker_container" "fluentd" {
  depends_on = [
    docker_network.vault-ent-network,
    docker_container.splunk,
    docker_container.vault_s1,
    docker_container.vault_s2,
    docker_container.vault_s3
  ]
  image = docker_image.fluentd.latest
  name  = var.container_name_fluentd
  networks_advanced {
    name = docker_network.vault-ent-network.name
  }
  ports {
    internal = var.docker_port_internal_fluentd
    external = var.docker_port_external_fluentd
  }
  ports {
    internal = var.docker_port_internal_fluentd
    external = var.docker_port_external_fluentd
    protocol = var.docker_protocol_fluentd
  }
  restart = var.docker_restart_telegraf
  volumes {
    host_path      = dirname(local_file.fluentd-config.filename)
    container_path = "/fluentd/etc"
    #    volume_name = "vault-ent-fluentd-config"
  }
  mounts {
    target    = "/var/log/vault"
    type      = "bind"
    source    = var.path_vault_log
    # read_only = true
  }
}

################################################
# TELEGRAF CONTAINER

resource "docker_image" "telegraf" {
  name         = "${var.container_image_telegraf}:${var.container_tag_telegraf}"
  keep_locally = false
}

resource "docker_container" "telegraf" {
  depends_on = [
    docker_network.vault-ent-network,
    docker_container.splunk
  ]
  image = docker_image.telegraf.latest
  name  = var.container_name_telegraf
  networks_advanced {
    name = docker_network.vault-ent-network.name
  }
  ports {
    internal = var.docker_port_internal_telegraf
    external = var.docker_port_external_telegraf
  }
  restart = var.docker_restart_vault
  volumes {
    host_path      = dirname(local_file.telegraf-config.filename)
    container_path = "/etc/telegraf"
    #    volume_name = "vault-ent-telegraf-config"
  }
}

################################################
# VAULT CONTAINERS

resource "docker_image" "vault-ent" {
  name         = "${var.container_image_vault}:${var.container_tag_vault}"
  keep_locally = true
}

resource "docker_container" "vault_s1" {
  depends_on = [
    docker_network.vault-ent-network,
    docker_container.splunk
  ]
  image = docker_image.vault-ent.latest
  name  = var.container_name_vault_s1
  capabilities {
    add = ["IPC_LOCK"]
  }
  networks_advanced {
    name         = docker_network.vault-ent-network.name
    aliases      = ["vault_s1"]
    ipv4_address = "10.88.0.18"
  }
  ports {
    internal = var.docker_port_internal_vault
    external = var.docker_port_external_vault_s1
  }
  restart = var.docker_restart_vault
  volumes {
    host_path = dirname(local_file.vault_s1-config.filename)
    #host_path      = var.path_vault_s1_config
    container_path = "/vault/config"
    #    volume_name = "vault-ent-vault_s1-config"
  }
  volumes {
    host_path = dirname(local_file.vault_s1-ipconfig.filename)
    #host_path      = var.path_vault_s1_config
    container_path = "/vault/config"
    #    volume_name = "vault-ent-vault_s1-ipconfig"
  }
  volumes {
    #host_path      = dirname(local_file.vault_s1-data.filename)
    container_path = "/vault/data"
  }
  volumes {
    host_path      = dirname(local_file.vault_s1-license.filename)
    container_path = "/vault/config"
    #    volume_name = "vault-ent-vault-license"
  }
  volumes {
    host_path      = dirname(local_file.vault_s1-log.filename)
    container_path = "/var/log/vault"
  }
  entrypoint = [
    "vault",
    "server",
    "-config=/vault/config"
  ]
}

resource "docker_container" "vault_s2" {
  depends_on = [
    docker_network.vault-ent-network,
    docker_container.splunk
  ]
  image = docker_image.vault-ent.latest
  name  = var.container_name_vault_s2
  capabilities {
    add = ["IPC_LOCK"]
  }
  networks_advanced {
    name         = docker_network.vault-ent-network.name
    aliases      = ["vault_s2"]
    ipv4_address = "10.88.0.28"
  }
  ports {
    internal = var.docker_port_internal_vault
    external = var.docker_port_external_vault_s2
  }
  restart = var.docker_restart_vault
  volumes {
    host_path = dirname(local_file.vault_s2-config.filename)
    #host_path      = var.path_vault_s2_config
    container_path = "/vault/config"
    #    volume_name = "vault-ent-vault_s2-config"
  }
  volumes {
    host_path = dirname(local_file.vault_s2-ipconfig.filename)
    #host_path      = var.path_vault_s2_config
    container_path = "/vault/config"
    #    volume_name = "vault-ent-vault_s2-ipconfig"
  }
  volumes {
    #host_path      = dirname(local_file.vault_s2-data.filename)
    container_path = "/vault/data"
  }
  volumes {
    host_path      = dirname(local_file.vault_s2-license.filename)
    container_path = "/vault/config"
    #    volume_name = "vault-ent-vault-license"
  }
  volumes {
    host_path      = dirname(local_file.vault_s2-log.filename)
    container_path = "/var/log/vault"
  }
  entrypoint = [
    "vault",
    "server",
    "-config=/vault/config"
  ]
}

resource "docker_container" "vault_s3" {
  depends_on = [
    docker_network.vault-ent-network,
    docker_container.splunk
  ]
  image = docker_image.vault-ent.latest
  name  = var.container_name_vault_s3
  capabilities {
    add = ["IPC_LOCK"]
  }
  networks_advanced {
    name         = docker_network.vault-ent-network.name
    aliases      = ["vault_s3"]
    ipv4_address = "10.88.0.38"
  }
  ports {
    internal = var.docker_port_internal_vault
    external = var.docker_port_external_vault_s3
  }
  restart = var.docker_restart_vault
  volumes {
    host_path = dirname(local_file.vault_s3-config.filename)
    #host_path      = var.path_vault_s3_config
    container_path = "/vault/config"
    #    volume_name = "vault-ent-vault_s3-config"
  }
  volumes {
    host_path = dirname(local_file.vault_s3-ipconfig.filename)
    #host_path      = var.path_vault_s3_config
    container_path = "/vault/config"
    #    volume_name = "vault-ent-vault_s3-ipconfig"
  }
  volumes {
    #host_path      = dirname(local_file.vault_s3-data.filename)
    container_path = "/vault/data"
  }
  volumes {
    host_path      = dirname(local_file.vault_s3-license.filename)
    container_path = "/vault/config"
    #    volume_name = "vault-ent-vault-license"
  }
  volumes {
    host_path      = dirname(local_file.vault_s3-log.filename)
    container_path = "/var/log/vault"
  }
  entrypoint = [
    "vault",
    "server",
    "-config=/vault/config"
  ]
}

################################################






