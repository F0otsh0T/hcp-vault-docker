# outputs.tf

output "k3d_context" {
#  value="k3d_cluster.${var.cluster_name}.network"
  value=k3d_cluster.mycluster.network
  description = "K3d Cluster Context"
}



















