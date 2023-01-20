################################################################################
# VAULT ENTERPRISE ON DOCKER
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
#   - Terraform
################################################################################

#SHELL := /bin/bash

################################
# FOUNDATION
################################
default: help
.PHONY: clean clean-volume clean-all vault-all vault-setup vault-init vault-restart-unseal vault-restart vault-unseal

################################
# CLEAN
################################
clean: #target ## Clean Vault
	@terraform destroy -auto-approve

clean-volume: #target ## Clean Vault Volume
	@rm -rf /var/tmp/volume/vault-ent/*

clean-all: clean clean-volume #target ## Clean All

################################
# SETUP AND RUN VAULT - PERSIST DATA WITH FILE VOLUME
# MAY NEED TO ENABLE FILE SHARING TO DOCKER VIA:
# DOCKER >> PREFERENCES >> RESOURCES >> FILE SHARING
################################
vault-all: vault-setup vault-init #target ## All Setup Targets for Vault Services

vault-setup: #target ## Spin Up Vault Resources
	@terraform init && terraform apply -auto-approve

################################
# VAULT INIT
# INIT, RAFT JOIN, UNSEAL 
################################
vault-init: #target ## Initialize Vault
#	# Initiate Vault with 1 Unseal Key Shares & 1 Threshold to Unseal
#	# Method Origin: https://github.com/nicklhw/vault-docker-compose
	@cd data/scripts && \
	chmod 754 *.sh && \
	./api_addr.sh vault_s1 vault_s2 vault_s3 && \
	./init.sh
#   # Added line 56 because the same command in the `./init.sh` does not appear to be firing off for some reason...

vault-restart-unseal: vault-restart vault-unseal #target ## Restart and Unseal Vault

################################
# VAULT UNSEAL
# BAU - NOT FOR INIT UNSEAL
################################
#	# Unseal Vault  ## Unseal Vault
#	# Method Origin: https://github.com/jacobm3/vault-local-demo/blob/9f5cce33ba34ff2cde1bfe2183bdeca6251421f0/reinit.sh#L21
vault-unseal: #target ## Vault Unseal (Business as Usual)
#	vault operator unseal $(jq -r .unseal_keys_b64[0] < keys.json)
	@cd data/scripts && \
	chmod 754 unseal-cli.sh && \
	./unseal-cli.sh

################################
# VAULT RESTART SET API ADDR
################################
vault-restart: #target ## Restart Vault Containers & Reset API ADDR
	@cd data/scripts && \
	chmod 754 api_addr.sh && \
	./api_addr.sh vault_s1 vault_s2 vault_s3

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

