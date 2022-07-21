#!/bin/bash

# Script by https://github.com/nicklhw

# This scripts detects the IP address for vault servers, writes it to a config file, then restarts Vault
for server in $@
do
    export ip=$(docker inspect ${server} -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')
    echo "IP address of ${server}: ${ip}"
    echo "Writing config file: /var/tmp/volume/vault-ent/${server}/config/addr.hcl"
cat <<EOF > /var/tmp/volume/vault-ent/${server}/config/addr.hcl
api_addr = "http://${ip}:8200"
cluster_addr = "https://${ip}:8201"
EOF
cat <<EOF > ../vault/${server}/addr.hcl
api_addr = "http://${ip}:8200"
cluster_addr = "https://${ip}:8201"
EOF
    echo "starting ${server}"
    docker restart $server
done
