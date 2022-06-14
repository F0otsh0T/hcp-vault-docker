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

##########
# CLEAN
##########
clean: #target
	docker stop vault
	docker rm vault

clean-volume: #target
	rm -rf ~/volume/vault/*

clean-dev: #target
	docker stop vault-dev
	docker rm vault-dev

clean-dev-volume: #target
	docker volume rm vault-file
	docker volume rm vault-logs


##########
# SETUP AND RUN VAULT DEV ENVIRONMENT - DEV MODE
# NOTE: DEV MODE DATA DOES NOT PERSIST ON RESTART
##########
vault-setup-dev: #target
	docker run -d --name vault-dev -p 8200:8200 --restart=unless-stopped vault:1.9.3 server -dev -dev-root-token-id="root"
	export VAULT_ADDR='http://127.0.0.1:8200'
	docker logs vault-dev


##########
# SETUP AND RUN VAULT - PERSIST DATA WITH FILE VOLUME
# MAY NEED TO ENABLE FILE SHARING TO DOCKER VIA:
# DOCKER >> PREFERENCES >> RESOURCES >> FILE SHARING
##########
vault-setup-all: vault-volume vault-setup vault-init vault-unseal #target

vault-volume: #target
#	# Volume directories chosen here are arbitrary.
#	# You can create and point to whatever directory you want.
#	# These will be used to mount into the Vault Application.
#	mkdir -p ~/volume/vault/config ~/volume/vault/file ~/volume/vault/logs ~/volume/vault/tls
	mkdir -p ~/volume/vault/config ~/volume/vault/file
	cp config.json ~/volume/vault/config
	volume=~/volume

vault-setup: #target
#	docker run -d --name vault -v ${volume}/vault/logs:/var/log -p 8200:8200 --restart=unless-stopped vault:1.9.3 server
#	docker run -d --name vault -v ~/volume/vault/config:/vault/config -v ~/volume/vault/file:/vault/file -v ~/volume/vault/logs:/vault/logs -v ~/volume/vault/tls:/vault/tls -p 8200:8200 --restart=unless-stopped --privileged vault:1.9.3 server
#	docker run -d --name vault -v ~/volume/vault/config:/vault/config -v ~/volume/vault/file:/vault/file -v ~/volume/vault/logs:/vault/logs -v ~/volume/vault/tls:/vault/tls -p 8200:8200 --restart=unless-stopped --cap-add IPC_LOCK vault:1.9.3 server
	docker run -d --name vault -v ~/volume/vault/config:/vault/config -v ~/volume/vault/file:/vault/file -p 8200:8200 --restart=unless-stopped --cap-add IPC_LOCK vault:1.9.3 server
	export VAULT_ADDR='http://127.0.0.1:8200'
	docker logs vault
##########
# ^^ Find Unseal Token via ```docker logs {{CONTAINER_NAME}}```
# ```vault operator unseal {{UNSEAL_TOKEN}}```
##########


##########
# VAULT INIT
#
##########
vault-init: #target
#	# Initiate Vault with 1 Unseal Key Shares & 1 Threshold to Unseal
#	# Method Origin: https://github.com/jacobm3/vault-local-demo/blob/9f5cce33ba34ff2cde1bfe2183bdeca6251421f0/reinit.sh#L21
	vault operator init -format=json -t 1 -n 1 | tee keys.json

vault-init-curl: #target
	curl \
    	--request POST \
    	--data @json/operator-init.json \
    	http://127.0.0.1:8200/v1/sys/init \
		| jq > keys.json


##########
# VAULT UNSEAL
#
##########
#	# Unseal Vault
#	# Method Origin: https://github.com/jacobm3/vault-local-demo/blob/9f5cce33ba34ff2cde1bfe2183bdeca6251421f0/reinit.sh#L21
vault-unseal: #target
#	vault operator unseal $(jq -r .unseal_keys_b64[0] < keys.json)
	chmod 754 unseal-cli.sh
	./unseal-cli.sh

vault-unseal-curl: #target
#	vault operator unseal $(jq -r .keys_base64[0] < keys.json)
#	$(shell chmod 754 unseal-curl.sh && ./unseal-curl.sh)
	chmod 754 unseal-curl.sh
	./unseal-curl.sh

