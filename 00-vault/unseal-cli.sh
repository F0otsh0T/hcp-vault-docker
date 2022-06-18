#!/bin/bash

# Vault Unseal for Curl Output
#echo $(jq -r .unseal_keys_b64[0] < keys.json)
vault operator unseal $(jq -r .unseal_keys_b64[0] < keys.json)