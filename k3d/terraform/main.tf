# main.tf

provider "k3d" {
  # Configuration options
}

resource "k3d_cluster" "mycluster" {
  name    = var.cluster_name
  servers = 1
  agents  = 2

  kubeconfig {
    update_default_kubeconfig = true
    switch_current_context    = false
  }

  k3s {
    extra_args {
      arg          = "--tls-san=${var.arg_tls_san}"
      node_filters = ["${var.arg_tls_nodefilter_group}:*"]
    }
  }

}






