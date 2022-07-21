# network.tf

################################################
# INFRASTRUCUTRE: NETWORK
################################################

resource "docker_network" "vault-ent-network" {
  name        = "vault-ent-network"
  driver      = "bridge"
  ipam_driver = "default"
  ipam_config {
    gateway = "10.88.0.1"
    subnet  = "10.88.0.0/16"
  }
}


