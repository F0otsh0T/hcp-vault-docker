# INFRA // Application - Nginx

##

- https://registry.terraform.io/providers/hashicorp/helm
- https://github.com/hashicorp/terraform-provider-helm
- https://github.com/bitnami/charts/tree/master/bitnami/nginx/

## 

```
.
├── README.md
├── env
│   └── local.tfvars
├── main.tf
├── outputs.tf
├── values.yaml
├── variables.tf
└── versions.tf
```

## Requirements

- Docker
- helm
- helm cli
- k3s
- k3d
- k8s
- kubectl
- Terraform

## Providers

| Name | Version |
|------|---------|
| <a name="h3lm"></a> [hashicorp/helm](https://registry.terraform.io/providers/hashicorp/helm) | >=2.4.1|

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [k3d.k3d_cluster](https://registry.terraform.io/providers/pvotal-tech/k3d/latest/docs/resources/cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="my_cluster"></a> [my_cluster](#) | Name for Docker Container |  | my-cluster | no |
| <a name="arg_tls_san"></a> [arg_tls_san](#)* | Specify argument to pass for --k3s-arg tls-san |  | 192.168.65.2 | yes |
| <a name="arg_tls_nodefilter_group"></a> [arg_tls_nodefilter_group](#) | Specify argument to pass for --k3s-arg nodefilter group |  | server (validation) | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="k3d_context"></a> [k3d_context](#) | n/a |

## Appendix

`*`This is important for Vault to trust the K8s Cert

[[]]