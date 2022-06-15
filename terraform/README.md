# INFRA // Vault - Terraform

## References

- https://www.terraform.io/cli/run
- https://learn.hashicorp.com/collections/terraform/docker-get-started

## Files

```
.
├── README.md
├── vault-dev
│   ├── README.md
│   ├── data.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── variables.tf
│   └── versions.tf
└── vault-file
    ├── README.md
    ├── data.tf
    ├── main.tf
    ├── outputs.tf
    ├── variables.tf
    └── versions.tf
```

## Vault in Docker - Dev Mode

```./vault-dev``` **Terraform** Workspace performs the same function as ```Makefile``` target ```vault-setup-dev```.

## Vault in Docker - File Mode

```./vault-file``` **Terraform** Workspace performs the same function as ```Makefile``` target ```vault-setup-all```.

~~As of this release, **Terraform** state is not aware of any files written by **Vault** in the ```var.path_vault_file``` specified path so you may need to clean those directories up manually between spinning up **Vault** File Mode instances. If the directory is not cleaned up, the new instance will just mount the old files.~~

