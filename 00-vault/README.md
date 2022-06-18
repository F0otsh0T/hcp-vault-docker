# INFRA // HASHICORP VAULT OSS in Docker

Testing or Prototype Environment // Running **Vault** in Docker for ***DEVELOPMENT PURPOSES ONLY***

## Introduction

This is an attempt to document how to spin up a quick Open-Source instance of **Vault** in Docker for development purposes.

## Prerequisites

- Docker
- Vault CLI
- make
- jq
- curl
- PGP / pass

## Dev Mode

> **NOTE**: In this mode, the data is **NOT** persistent

https://www.vaultproject.io/docs/concepts/dev-server
https://www.vaultproject.io/docs/configuration/storage/in-memory

- Start up **Vault** in "dev" mode in Docker Runtime:

    ```
    make -f Makefile vault-setup-dev
    ```
- This will auto-unseal with access via Admin or Root token == ```root```

## File Volume Mode

https://www.vaultproject.io/docs/configuration/storage/filesystem

> **NOTE**: This is inherently **NOT** secure and should only be used for development / prototyping purposes only.

Steps documented in the steps below can all be done in one command by running ```make``` against the ```vault-setup-all``` target: ```make -f Makefile vault-set-all```

- Create directories on your node that will be mounted into the **Vault** Docker Container
    ```
    mkdir -p ~/volume/vault/config ~/volume/vault/file ~/volume/vault/logs ~/volume/vault/tls
    ```
    **OR**
    ```
    make -f Makefile vault-volume
    ```
- **Vault** Configuration: ~~Copy the ```~/config.json``` configuration file to the ```${volume}/vault/config``` directory you created.~~ This has been covered in the Makefile ```vault-volume: #target``` & will pass configuration values to start **Vault**
- Start up **Vault** in Docker Runtime:
    ```
    make -f Makefile vault-setup
    ```
- Inititiate and Unseal **Vault**
  - ```vault operator init```: Initializes Vault and dumps output to ```keys.json```
    ```
    make -f Makefile vault-init
    ```
  - ```vault operator unseal```: Unseals Vault with values from ```keys.json```
    ```
    make -f Makefile vault-unseal
    ```
- Log in to Vault with your new *Initial Root Token* (in ```keys.json``` file)
    ```
    vault login <token>
    ```
- Set your environment variables for ```VAULT_ADDR``` and ```VAULT_TOKEN```

> If you are successfully logged into **Vault** CLI via initial token but get errors like "*Code: 403. Errors: * permission denied*" when executing **Vault** CLI commands, you may need to "```tidy```" your **Vault** tokens as per:
> - https://github.com/hashicorp/vault/issues/3859#issuecomment-361089610
> - https://github.com/hashicorp/vault/issues/2661
> - Command to tidy tokens:
>   ```
>   curl -H "X-Vault-Token: $VAULT_TOKEN" -X POST http://127.0.0.1:8200/v1/auth/token/tidy
>   ```
- Upon **Vault** service restart (or host node reboot), you will need to unseal again (no need to ```vault-init #target```). Run make against the ```vault-unseal #target``` to unseal **Vault** assuming ```keys.json``` file is available for it to parse the *Unseal Key*(s).
    ```
    make -f Makefile vault-unseal
    ```


## General Notes

At this point, it would be good to do the following:
- Save the Shamir *Unseal Key*(s) & *Initial Root Token* in the ```keys.json``` somewhere safe
- Create another token or ```userpass``` account with **admin** level policy


## References

- https://hub.docker.com/_/vault
- https://www.vaultproject.io/docs/concepts/dev-server
- https://www.vaultproject.io/docs/configuration/storage
- https://github.com/hashicorp/vault/issues/3859#issuecomment-361089610
- https://github.com/hashicorp/vault/issues/2661
- https://github.com/jacobm3/vault-local-demo/blob/9f5cce33ba34ff2cde1bfe2183bdeca6251421f0/reinit.sh#L21
- https://github.com/MarkNjunge/vault-docker/blob/master/1-unseal.sh


## Appendix

DEPRECATED:
The ```init-unseal.sh``` script will perform:
    - ```vault operator init```
    - Dump Shamir *Unseal Key*(s) and *Initial Root Token* into ```keys.json``` file 
    - ```vault operator unseal```
  - Run ```init-unseal.sh``` script or do steps in the script manually
    ```
    chmod 754 init-unseal.sh
    ./init-unseal.sh
    ```

## 

[Introduction](#introduction)
[Prerequisites](#prerequisites)
[Dev Mode](#dev-mode)
[File Volume Mode](#file-volume-mode)
[References](#references)
[Appendix](#appendix)