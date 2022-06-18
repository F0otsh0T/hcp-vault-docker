# main.tf

provider "k3d" {
  # Configuration options
}

resource "k3d_cluster" "mycluster" {
  name    = var.cluster_name
  servers = 1
  agents  = 2

  port {
    host_port      = var.port0_host_port
    container_port = var.port0_container_port
    node_filters = [
      "server:*",
      "agent:*"
    ]
  }

  port {
    host_port      = var.port1_host_port
    container_port = var.port1_container_port
    node_filters = [
      "server:*",
      "agent:*"
    ]
  }

  kubeconfig {
    update_default_kubeconfig = true
    switch_current_context    = false
  }

  k3s {
    extra_args {
      arg          = "--tls-san=${var.arg_tls_san}"
      node_filters = [
        "${var.arg_tls_nodefilter_group}:*"
      ]
    }
  }

}






