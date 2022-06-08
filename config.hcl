listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = "true"
}

storage "file" {
  path = "/vault/file"
}

disable_mlock = true
log_level = "trace"
ui = true
