# INFRA // Vault

## References

https://registry.terraform.io/providers/hashicorp/helm
https://github.com/hashicorp/terraform-provider-helm
https://hub.docker.com/_/vault

## Files

```
.
├── data.tf
├── main.tf
├── outputs.tf
├── variables.tf
└── versions.tf
```

## Requirements

- Docker
- Terraform

## Providers

| Name | Version |
|------|---------|
| <a name="docker"></a> [kreuzwerker/docker](https://registry.terraform.io/providers/kreuzwerker/docker) | >=2.16.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [docker.docker_container](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container) | resource |
| [docker.docker_image](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="docker_tag"></a> [docker_tag](#) | Vault Version or Docker Tag |  | 1.9.4 | no |
| <a name="container_name"></a> [container_name](#) | Name for Docker Container |  | vault-dev | no |
| <a name="docker_port_internal"></a> [docker_port_internal](#) | Port Internal for Docker Container |  | 8200 | no |
| <a name="docker_port_external"></a> [docker_port_external](#) | Port External for Docker Container |  | 9200 | no |
| <a name="docker_restart"></a> [docker_restart](#) | Restart Policy for Docker Container |  | unless-stopped | no |
| <a name="vault_root_token"></a> [vault_root_token](#) | Root Token for Vault Service |  |  | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="docker_name"></a> [docker_name](#) | n/a |

