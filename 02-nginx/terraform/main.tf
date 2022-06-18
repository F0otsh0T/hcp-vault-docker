# main.tf


provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "nginx" {
  name = "mynginx1"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"
  version    = "12.0.4"

  values = [
    "${file("values.yaml")}"
  ]

/*   values = [
    "${file("values.test.yaml")}"
  ] */

}







