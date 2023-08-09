#!/bin/bash

export VAULT_TOKEN="$(jq -r .root_token < vault.json)"
#export VAULT_TOKEN="$(pass poc/vault-root)"
export VAULT_UNSEAL="$(jq -r .unseal_keys_b64[0] < vault.json)"
#export VAULT_UNSEAL="$(pass poc/vault-shamir64)"

declare -a ARRAY=( "18200" "28200" "38200" )
#declare -a ARRAY=( "18200" )
#declare -a ARRAY=( "28200" )
#declare -a ARRAY=( "38200" )

for S in "${ARRAY[@]}"; do
    echo "Unseal Vault Memeber @ http://0.0.0.0:$S"
    export VAULT_ADDR=http://0.0.0.0:$S && vault operator unseal ${VAULT_UNSEAL}
    sleep 5
done

echo "*** Cluster Members ***"
vault operator members -format=json | jq

echo "*** Raft List-Peers ***"
vault operator raft list-peers -format=json | jq
