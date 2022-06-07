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

##########
# CLEANUP
#
clean: #target
	docker stop vault
	docker rm vault

clean-dev: #target
	docker stop vault-dev
	docker rm vault-dev

clean-volumes: #target
	docker volume rm vault-file
	docker volume rm vault-logs
	rm -rf ~/volume/vault

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
vault-setup-volume: #target
#	# Volume directories chosen here are arbitrary.
#	# You can create and point to whatever directory you want.
#	# These will be used to mount into the Vault Application.
	mkdir -p ~/volume/vault/config ~/volume/vault/file ~/volume/vault/logs ~/volume/vault/tls
	volume=~/volume

vault-setup: #target
#	docker run -d --name vault -v ${volume}/vault/logs:/var/log -p 8200:8200 --restart=unless-stopped vault:1.9.3 server
#	docker run -d --name vault -v ~/volume/vault/config:/vault/config -v ~/volume/vault/file:/vault/file -v ~/volume/vault/logs:/vault/logs -v ~/volume/vault/tls:/vault/tls -p 8200:8200 --restart=unless-stopped --privileged vault:1.9.3 server
	docker run -d --name vault -v ~/volume/vault/config:/vault/config -v ~/volume/vault/file:/vault/file -v ~/volume/vault/logs:/vault/logs -v ~/volume/vault/tls:/vault/tls -p 8200:8200 --restart=unless-stopped --cap-add IPC_LOCK vault:1.9.3 server
	export VAULT_ADDR='http://127.0.0.1:8200'
	docker logs vault
##########
# ^^ Find Unseal Token via ```docker logs {{CONTAINER_NAME}}```
# ```vault operator unseal {{UNSEAL_TOKEN}}```
##########


##########
#
#
##########


