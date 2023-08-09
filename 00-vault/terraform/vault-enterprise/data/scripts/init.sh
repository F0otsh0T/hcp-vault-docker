#!/bin/bash

# Script by https://github.com/nicklhw

set -euo pipefail

sleep 15

# Docker compose IP address fix
./api_addr.sh vault_s1 vault_s2 vault_s3

export VAULT_S1_IP=$(docker inspect vault_s1 -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')

# Init vault_s1
echo "Init and unseal vault_s1"
export VAULT_ADDR=http://localhost:18200
sleep 10
vault operator init -format=json -n 1 -t 1 | tee vault.json

export VAULT_TOKEN=$(cat vault.json | jq -r '.root_token')
echo "Root VAULT TOKEN is: $VAULT_TOKEN"

# Unseal vault_s1
echo "Unseal vault_s1"
export VAULT_ADDR=http://localhost:18200

export unseal_key=$(cat vault.json | jq -r '.unseal_keys_b64[0]')
vault operator unseal ${unseal_key}

sleep 10

# Join vault_s2
echo "Join vault_s2"
export VAULT_ADDR=http://localhost:28200
vault operator raft join http://${VAULT_S1_IP}:8200

# Unseal vault_s2
echo "Unseal vault_s2"
vault operator unseal ${unseal_key}

# Join vault_s3
echo "Join vault_s3"
export VAULT_ADDR=http://localhost:38200
vault operator raft join http://${VAULT_S1_IP}:8200

# Unseal vault_s3
echo "Unseal vault_s3"
vault operator unseal ${unseal_key}

# Reset vault addr and add vault token
export VAULT_ADDR=http://localhost:18200

sleep 10

echo "*** Cluster Members ***"
vault operator members

echo "*** Enable Audit Device ***"

export VAULT_TOKEN=$(cat vault.json | jq -r '.root_token')

echo "*** Please Run: export VAULT_TOKEN=${VAULT_TOKEN}"

vault audit enable file file_path=/var/log/vault/vault-audit.log mode=744
