# HCP VAULT - INFRA // TESTBED

HashiCorp Vault (OSS) Testbed

## INTRODUCTION

Testbed consists of:
- Vault in Docker
- K3d/K3s Kubernetes Runtime
- Application(s): NGINX

## REFERENCES

- https://www.terraform.io/cli/run
- https://learn.hashicorp.com/collections/terraform/docker-get-started

## DIRECTORIES

```
.
├── 00-vault
├── 01-k3d
└── 02-nginx
```

## SEQUENCE

Order of Testbed Spin Up:
1. [Vault](00-vault/)
2. [K3d](01-k3d/)
3. [NGINX](02-nginx/)


[[]]