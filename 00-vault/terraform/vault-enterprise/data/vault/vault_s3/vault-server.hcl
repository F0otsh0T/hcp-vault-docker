storage "raft" {
  path = "/vault/data"
  node_id = "vault_s3"
  performance_multiplier = "1"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = "true"
}

telemetry {
  dogstatsd_addr = "vault-telegraf:8125"
  enable_hostname_label = true
  prometheus_retention_time = "0h"
}

cluster_name = "primary"
ui = "true"
#log_level="TRACE"

license_path = "/vault/config/vault.hclic"
