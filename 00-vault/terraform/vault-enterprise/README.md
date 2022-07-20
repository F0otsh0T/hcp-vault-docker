---
tags:
  - docker
  - arm64
  - hashicorp
  - hcp-vault
  - vault
  - hcp-terraform
  - terraform
  - raft
  - dr
  - fluentd
  - splunk
  - telegraf
  - tech
alias:
  - Vault Enterprise Raft DR Cluster
---

---
# INFRA // Vault Enterprise - Raft DR Cluster

Vault Enterprise in a DR Cluster with Raft Storage Backend.

## Introduction

Credit goes to ***[nicklhw@github](https://github.com/nicklhw)*** as these Terraform templates are based off ***[nicklhw's](https://github.com/nicklhw)*** design, research, and scripts to stand up a local **VAULT** Enterprise Cluster.

This spins up:

- 3 Node (Container) Vault DR Cluster
- Telegraf
- FluentD
- Splunk (*Needs HashiCorp Vault Application)

## Caveats

- HCLIC: You will need to provide your own Vault Enterprise License File
- Splunk Hashicorp Vault Application TGZ: You will need to provide this from your Splunk subscription
- ARM64/V8 or Mac M1:
  - Splunk does not support ARM64/V8 nor Mac M1 architecture in Docker
  - FluentD may have some issues running in AMD64 Emulation Mode

## References

- https://www.terraform.io/cli/run
- https://learn.hashicorp.com/collections/terraform/docker-get-started
- https://registry.terraform.io/providers/kreuzwerker/docker
- https://hub.docker.com/_/vault

## Files

```
.
├── Makefile
├── README.md
├── data
│   ├── fluentd
│   │   ├── Dockerfile
│   │   └── conf
│   │       └── fluent.conf
│   ├── scripts
│   │   ├── api_addr.sh
│   │   ├── init.sh
│   │   └── unseal-cli.sh
│   ├── splunk
│   │   ├── atunnecliffe
│   │   │   ├── Dockerfile
│   │   │   ├── LICENSE
│   │   │   ├── README.md
│   │   │   ├── ca_profile.xml
│   │   │   ├── gosplunk.sh
│   │   │   └── splunkunraid.xml
│   │   ├── build
│   │   │   ├── ~~Dockerfile~~
│   │   │   ├── files
│   │   │   │   ├── keepalive.sh
│   │   │   │   └── msg-buildtest
│   │   │   └── terraform.tfstate
│   │   ├── default.yml
│   │   └── ~~hashicorp-vault-app-for-splunk_103.tgz~~
│   ├── telegraf
│   │   └── telegraf.conf
│   └── vault
│       ├── shared
│       │   └── ~~vault.hclic~~
│       ├── vault_s1
│       │   ├── addr.hcl
│       │   └── vault-server.hcl
│       ├── vault_s2
│       │   ├── addr.hcl
│       │   └── vault-server.hcl
│       └── vault_s3
│           ├── addr.hcl
│           └── vault-server.hcl
├── main.tf
├── network.tf
├── outputs.tf
├── provider.tf
├── storage.tf
├── variables.tf
├── ~~vault.auto.tfvars~~
└── versions.tf
```

## Requirements

- Docker
- Terraform
- jq
- GPG / PGP / Pass

## Usage

#### Spin Up

```shell
make -f Makefile vault-all
```

#### Spin Down

```shell
make -f Makefile clean-all
```

## Providers

| Name | Version |
|------|---------|
| <a name="local"></a> [hashicorp/local](https://registry.terraform.io/providers/hashicorp/local) | >=2.1.0 |
| <a name="docker"></a> [kreuzwerker/docker](https://registry.terraform.io/providers/kreuzwerker/docker) | >=2.16.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [docker.docker_container](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container) | resource |
| [docker.docker_image](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image) | resource |
| [docker.docker_network](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/network) | resource |
| [local.local_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="path_splunk_hashi_app"></a> [path_splunk_hashi_app](#) | Specify path on local disk to mount Splunk Container /tmp/<name of Splunk HashiCorp Vault App> |  | /var/tmp/volume/vault-ent/splunk/tmp | yes |
| <a name="splunk_hashi_app"></a> [splunk_hashi_app](#) | HashiCorp Vault Splunk App Package |  | hashicorp-vault-app-for-splunk_103.tgz | yes |
| <a name="path_splunk_config"></a> [path_splunk_config](#) | Specify path on local disk to mount Splunk Container /tmp/defaults |  | /var/tmp/volume/vault-ent/splunk/tmp/defaults | yes |
| <a name="path_telegraf_config"></a> [path_telegraf_config](#) | Specify path on local disk to mount Telegraf Container /etc/telegraf |  | /var/tmp/volume/vault-ent/telegraf/etc/telegraf | yes |
| <a name="path_fluent_config"></a> [path_fluent_config](#) | Specify path on local disk to mount FluentD Container /fluentd/etc |  | /var/tmp/volume/vault-ent/fluent/etc | yes |
| <a name="path_vault_s1_config"></a> [path_vault_s1_config](#) | Specify path on local disk to mount Vault Container /vault/config |  | /var/tmp/volume/vault-ent/vault_s1/config | yes |
| <a name="path_vault_s1_data"></a> [path_vault_s1_data](#) | Specify path on local disk to mount Vault Container /vault/data |  | /var/tmp/volume/vault-ent/vault_s1/data | yes |
| <a name="path_vault_s2_config"></a> [path_vault_s2_config](#) | Specify path on local disk to mount Vault Container /vault/config |  | /var/tmp/volume/vault-ent/vault_s1/config | yes |
| <a name="path_vault_s2_data"></a> [path_vault_s2_data](#) | Specify path on local disk to mount Vault Container /vault/data |  | /var/tmp/volume/vault-ent/vault_s1/data | yes |
| <a name="path_vault_s3_config"></a> [path_vault_s3_config](#) | Specify path on local disk to mount Vault Container /vault/config |  | /var/tmp/volume/vault-ent/vault_s1/config | yes |
| <a name="path_vault_s3_data"></a> [path_vault_s3_data](#) | Specify path on local disk to mount Vault Container /vault/data |  | /var/tmp/volume/vault-ent/vault_s1/data | yes |
| <a name="path_vault_log"></a> [path_vault_log](#) | Specify path on local disk to mount **SHARED** Vault Container /var/log/vault |  | /var/tmp/volume/vault-ent/log | yes |
| <a name="container_image_vault"></a> [container_image_vault](#) | Image Name of Vault Container |  | hashicorp/vault-enterprise | yes |
| <a name="container_tag_vault"></a> [container_tag_vault](#) | Image Tag of Vault Container |  | 1.11.0-ent | no |
| <a name="container_name_vault_s1"></a> [container_name_vault_s1](#) | Name of Vault Container |  | vault_s1 | yes |
| <a name="container_name_vault_s2"></a> [container_name_vault_s2](#) | Name of Vault Container |  | vault_s2 | yes |
| <a name="container_name_vault_s3"></a> [container_name_vault_s3](#) | Name of Vault Container |  | vault_s3 | yes |
| <a name="container_image_fluentd"></a> [container_image_fluentd](#) | Image Name of FluentD Container |  | fluentd | yes |
| <a name="container_tag_fluentd"></a> [container_tag_fluentd](#) | Image Tag of FluentD Container |  | v1.14-1 | no |
| <a name="container_name_fluentd"></a> [container_name_fluentd](#) | Name of FluentD Container |  | vault-fluentd | yes |
| <a name="container_image_splunk"></a> [container_image_splunk](#) | Image Name of Splunk Container |  | splunk/splunk | yes |
| <a name="container_tag_splunk"></a> [container_tag_splunk](#) | Image Tag of Splunk Container |  | 9.0.0 | no |
| <a name="container_name_splunk"></a> [container_name_splunk](#) | Name of Splunk Container |  | vault-splunk | yes |
| <a name="container_image_telegraf"></a> [container_image_telegraf](#) | Image Name of Telegraf Container |  | telegraf | yes |
| <a name="container_tag_telegraf"></a> [container_tag_telegraf](#) | Image Tag of Telegraf Container |  | 1.23 | no |
| <a name="container_name_telegraf"></a> [container_name_telegraf](#) | Name of Telegraf Container |  | vault-telegraf | yes |
| <a name="docker_port_internal_vault"></a> [docker_port_internal_vault](#) | Internal Port for Vault Container |  | 8200 | no |
| <a name="docker_port_external_vault_s1"></a> [docker_port_external_vault_s1](#) | External Port for Vault S1 Container |  | 18200 | yes |
| <a name="docker_port_external_vault_s2"></a> [docker_port_external_vault_s2](#) | External Port for Vault S2 Container |  | 28200 | yes |
| <a name="docker_port_external_vault_s1"></a> [docker_port_external_vault_s3](#) | External Port for Vault S3 Container |  | 38200 | yes |
| <a name="docker_port_internal_fluentd"></a> [docker_port_internal_fluentd](#) | Internal Port for FluentD Container |  | 24224 | no |
| <a name="docker_port_external_fluentd"></a> [docker_port_external_fluentd](#) | External Port for FluentD Container |  | 24224 | no |
| <a name="docker_protocol_fluentd"></a> [docker_protocol_fluentd](#) | Protocol for FluentD Container |  | udp | no |
| <a name="docker_port_internal_splunk"></a> [docker_port_internal_splunk](#) | Internal Port for Splunk Container Web |  | 8000 | no |
| <a name="docker_port_external_splunk"></a> [docker_port_external_splunk](#) | External Port for Splunk Container Web |  | 8000 | no |
| <a name="docker_port_internal_telegraf"></a> [docker_port_internal_telegraf](#) | Internal Port for Telegraf Container |  | 8125 | no |
| <a name="docker_port_external_telegraf"></a> [docker_port_external_telegraf](#) | External Port for Telegraf Container |  | 8125 | no |
| <a name="docker_protocol_telegraf"></a> [docker_protocol_telegraf](#) | Protocol for Telegraf Container |  | udp | no |
| <a name="docker_restart_vault"></a> [docker_restart_vault](#) | Restart Policy for Vault Container |  | unless-stopped | no |
| <a name="docker_restart_splunk"></a> [docker_restart_splunk](#) | Restart Policy for Splunk Container |  | always | no |
| <a name="docker_restart_telegraf"></a> [docker_restart_telegraf](#) | Restart Policy for Telegraf Container |  | always | no |
| <a name="vault_root_token"></a> [vault_root_token](#) | Root Token for Vault Service |  |  | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="container_name_vault_s1"></a> [container_name_vault_s1](#) | n/a |
| <a name="container_name_vault_s2"></a> [container_name_vault_s2](#) | n/a |
| <a name="container_name_vault_s3"></a> [container_name_vault_s3](#) | n/a |
| <a name="container_name_vault_fluentd"></a> [container_name_vault_fluentd](#) | n/a |
| <a name="container_name_vault_splunk"></a> [container_name_vault_splunk](#) | n/a |
| <a name="container_name_vault_telegraf"></a> [container_name_vault_telegraf](#) | n/a |
| <a name="container_ip_vault_s1"></a> [container_ip_vault_s1](#) | n/a |
| <a name="container_ip_vault_s2"></a> [container_ip_vault_s2](#) | n/a |
| <a name="container_ip_vault_s3"></a> [container_ip_vault_s3](#) | n/a |
| <a name="container_ip_vault_fluentd"></a> [container_ip_vault_fluentd](#) | n/a |
| <a name="container_ip_vault_telegraf"></a> [container_ip_vault_telegraf](#) | n/a |
| <a name="dirname_splunk_config"></a> [dirname_splunk_config](#) | n/a |
| <a name="dirname_splunk_hashi_app"></a> [dirname_splunk_hashi_app](#) | n/a |
| <a name="container_network"></a> [container_network](#) | n/a |


[[]]

## Sources
- https://splunk.github.io/docker-splunk/
- https://github.com/brianshumate/fluentd-splunk-hec
- https://docs.fluentd.org/v/0.12/input/forward
- https://docs.docker.com/config/containers/logging/fluentd/#fluentd-async
- https://www.fluentd.org/faqs
- https://github.com/fluent/fluent-plugin-splunk
- https://github.com/splunk/fluent-plugin-splunk-hec
- https://docs.splunk.com/Documentation/Splunk/9.0.0/Admin/TypesofSplunklicenses

## Appendix

- ARM64/V8 Potential Splunk Workarounds
  - https://github.com/splunk/docker-splunk/issues/516
  - https://hub.docker.com/r/odidev/docker-splunk/tags
- Splunk Container in Alpine
  - https://github.com/andrew207/splunk
- 