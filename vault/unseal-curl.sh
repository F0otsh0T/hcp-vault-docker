#!/bin/bash

# Vault Unseal for CLI Output
#echo $(jq -r .keys_base64[0] < keys.json)
vault operator unseal $(jq -r .keys_base64[0] < keys.json)