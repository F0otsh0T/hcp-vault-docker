# variables.tf

variable "tf-k3d_cluster-cluster_name" {
    type = string
    description = "Specify the TF K3d Resource Name for your K3d cluster"
    sensitive = false
    default = "mycluster"
}

variable "cluster_name" {
    type = string
    description = "Specify the Name for your K3d cluster"
    sensitive = false
    default = "mycluster"
}

variable "arg_tls_san" {
    type = string
    description = "Specify argument to pass for --k3s-arg tls-san"
    sensitive = false
    default = "192.168.65.2"
}

variable "arg_tls_nodefilter_group" {
    type = string
    description = "Specify argument to pass for --k3s-arg nodefilter group"
    sensitive = false
    default = "server"
    validation {
      condition = contains(["server", "servers", "agent", "agents", "loadbalancer", "all"], var.arg_tls_nodefilter_group)
      error_message = "Value must be server, servers, agent, agents, loadbalancer, all."
    }
}



