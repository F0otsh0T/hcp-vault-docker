# INFRA // Application - NGINX

##

- https://registry.terraform.io/providers/hashicorp/helm
- https://github.com/hashicorp/terraform-provider-helm
- https://artifacthub.io/packages/helm/bitnami/nginx
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
- helm 3.2.0+
- helm cli
- k3s
- k3d
- k8s 1.19+
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
| [helm.helm_release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="helm_release"></a> [helm_release](#) | Helm Release |  | mynginx1 | no |
| <a name="helm_release_repository"></a> [helm_release_repository](#) | Helm Release Repository |  | https://charts.bitnami.com/bitnami| yes |
| <a name="helm_release_chart"></a> [helm_release_chart](#) | Helm Release Chart |  | nginx | no |
| <a name="helm_release_version"></a> [helm_release_version](#) | Helm Release Version |  | 12.0.4 | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name=""></a> [](#) | n/a |

## Appendix

[[]]