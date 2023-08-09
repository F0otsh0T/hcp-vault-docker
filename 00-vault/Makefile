################################################################################
# VAULT ON DOCKER
#
# @file
# @version 0.1
#
##########
# PREREQUISITES
#   - Docker
#   - Vault CLI
#   - make
#   - jq
#   - curl
#   - PGP / pass
################################################################################

#SHELL := /bin/bash

################################
# DEFAULTS
################################
default: help

################################
# CLEAN
################################
.PHONY: clean
clean: #target ## Clean Vault
	docker stop vault
	docker rm vault

.PHONY: clean-volume
clean-volume: #target ## Clean Vault Volume
	rm -rf ~/volume/vault/*

.PHONY: clean-dev
clean-dev: #target ## Clean Vault Dev
	docker stop vault-dev
	docker rm vault-dev

.PHONY: clean-dev-volume
clean-dev-volume: #target ## Clean Vault Dev Volume
	docker volume rm vault-file
	docker volume rm vault-logs


################################
# SETUP AND RUN VAULT DEV ENVIRONMENT - DEV MODE
# NOTE: DEV MODE DATA DOES NOT PERSIST ON RESTART
################################
.PHONY: vault-setup-dev
vault-setup-dev: #target ## Setup Vault in Dev Mode
	docker run -d --name vault-dev -p 8200:8200 --restart=unless-stopped vault:1.9.3 server -dev -dev-root-token-id="root"
	export VAULT_ADDR='http://127.0.0.1:8200'
	docker logs vault-dev


################################
# SETUP AND RUN VAULT - PERSIST DATA WITH FILE VOLUME
# MAY NEED TO ENABLE FILE SHARING TO DOCKER VIA:
# DOCKER >> PREFERENCES >> RESOURCES >> FILE SHARING
################################
.PHONY: vault-setup-all
vault-setup-all: vault-volume vault-setup vault-init vault-unseal #target ## All Vault Setup Targets

.PHONY: vault-volume
vault-volume: #target ## Create Vault Volume (File)
#	# Volume directories chosen here are arbitrary.
#	# You can create and point to whatever directory you want.
#	# These will be used to mount into the Vault Application.
#	mkdir -p ~/volume/vault/config ~/volume/vault/file ~/volume/vault/logs ~/volume/vault/tls
	mkdir -p ~/volume/vault/config ~/volume/vault/file
	cp config.json ~/volume/vault/config
	volume=~/volume

.PHONY: vault-setup
vault-setup: #target ## Setup Vault
#	docker run -d --name vault -v ${volume}/vault/logs:/var/log -p 8200:8200 --restart=unless-stopped vault:1.9.3 server
#	docker run -d --name vault -v ~/volume/vault/config:/vault/config -v ~/volume/vault/file:/vault/file -v ~/volume/vault/logs:/vault/logs -v ~/volume/vault/tls:/vault/tls -p 8200:8200 --restart=unless-stopped --privileged vault:1.9.3 server
#	docker run -d --name vault -v ~/volume/vault/config:/vault/config -v ~/volume/vault/file:/vault/file -v ~/volume/vault/logs:/vault/logs -v ~/volume/vault/tls:/vault/tls -p 8200:8200 --restart=unless-stopped --cap-add IPC_LOCK vault:1.9.3 server
	docker run -d --name vault -v ~/volume/vault/config:/vault/config -v ~/volume/vault/file:/vault/file -p 8200:8200 --restart=unless-stopped --cap-add IPC_LOCK vault:1.9.3 server
	export VAULT_ADDR='http://127.0.0.1:8200'
	docker logs vault
################################
# ^^ Find Unseal Token via ```docker logs {{CONTAINER_NAME}}```
# ```vault operator unseal {{UNSEAL_TOKEN}}```
################################


################################
# VAULT INIT
#
################################
.PHONY: vault-init
vault-init: #target ## Initialize Vault
#	# Initiate Vault with 1 Unseal Key Shares & 1 Threshold to Unseal
#	# Method Origin: https://github.com/jacobm3/vault-local-demo/blob/9f5cce33ba34ff2cde1bfe2183bdeca6251421f0/reinit.sh#L21
	vault operator init -format=json -t 1 -n 1 | tee keys.json

.PHONY: vault-init-curl
vault-init-curl: #target ## Initialize Vault API
	curl \
    	--request POST \
    	--data @json/operator-init.json \
    	http://127.0.0.1:8200/v1/sys/init \
		| jq > keys.json


################################
# VAULT UNSEAL
#
################################
#	# Unseal Vault  ## Unseal Vault
#	# Method Origin: https://github.com/jacobm3/vault-local-demo/blob/9f5cce33ba34ff2cde1bfe2183bdeca6251421f0/reinit.sh#L21
.PHONY: vault-unseal
vault-unseal: #target
#	vault operator unseal $(jq -r .unseal_keys_b64[0] < keys.json)
	chmod 754 unseal-cli.sh
	./unseal-cli.sh

################################
# HELP
# REF GH @ jen20/hashidays-nyc/blob/master/terraform/GNUmakefile
################################
.PHONY: help
help: #target ## [DEFAULT] Display help for this Makefile.
	@echo "Valid make targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

check_defined = \
		$(strip $(foreach 1,$1, \
		$(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
		$(if $(value $1),, \
		$(error Undefined $1$(if $2, ($2))))






