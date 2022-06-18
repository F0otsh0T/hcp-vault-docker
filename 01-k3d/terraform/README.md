# INFRA // K3d
Rancher K3s Kubernetes Cluster in Docker

##

- https://www.terraform.io/cli/run
- https://registry.terraform.io/providers/pvotal-tech/k3d
- https://github.com/pvotal-tech/terraform-provider-k3d

## Files

```
.
├── README.md
├── data.tf
├── env
│   └── local.tfvars
├── main.tf
├── outputs.tf
├── variables.tf
└── versions.tf
```

## Requirements

- Docker
- kubectl
- k3s
- k3d
- Terraform

## Providers

| Name | Version |
|------|---------|
| <a name="k3d"></a> [pvotal-tech/k3d](https://registry.terraform.io/providers/pvotal-tech/k3d) | >=0.0.6|

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
| <a name="port0_host_port"></a> [port0_host_port](#) | Port0: Host Port |  | 30080 | no |
| <a name="port0_container_port"></a> [port0_container_port](#) | Port0: Container Port |  | 30080 | no |
| <a name="port1_host_port"></a> [port1_host_port](#) | Port1: Host Port |  | 30443 | no |
| <a name="port1_container_port"></a> [port1_container_port](#) | Port1: Container Port |  | 30443 | no |
| <a name="arg_tls_san"></a> [arg_tls_san](#)* | Specify argument to pass for --k3s-arg tls-san |  | 192.168.65.2 | yes |
| <a name="arg_tls_nodefilter_group"></a> [arg_tls_nodefilter_group](#) | Specify argument to pass for --k3s-arg nodefilter group |  | server (validation) | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="k3d_context"></a> [k3d_context](#) | n/a |

## Appendix

* This is important for Vault to trust the K8s Cert