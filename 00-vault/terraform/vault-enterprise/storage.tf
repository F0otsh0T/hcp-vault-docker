# volume.tf

################################################

resource "null_resource" "cleanup" {
  /*   provisioner "local-exec" {
    #    command = "rm -rf ${var.path_vault_config}"
    command = "mv ${var.path_vault_config} /tmp"
  }
  provisioner "local-exec" {
    #    command = "rm -rf ${var.path_vault_file}"
    command = "mv ${var.path_vault_file} /tmp"
  } */
}

################################################
# INFRASTRUCUTRE: STORAGE
################################################

/* resource "local_file" "fluent-vault-logs" {
  depends_on = [
    null_resource.cleanup
  ]
  source   = "${path.root}/data/splunk/${var.splunk_hashi_app}"
  filename = "${var.path_splunk_hashi_app}/${var.splunk_hashi_app}" */
/* file_permission = "0754" */
/*   provisioner "local-exec" {
    when    = destroy
    command = "cp -r ${dirname(self.filename)} /tmp/"
  } */
/* } */

resource "local_file" "fluentd-config" {
  depends_on = [
    null_resource.cleanup
  ]
  source   = "${path.root}/data/fluentd/conf/fluent.conf"
  filename = "${var.path_fluent_config}/fluent.conf"
  /* file_permission = "0644" */
  /*   provisioner "local-exec" {
    when    = destroy
    command = "cp -r ${dirname(self.filename)} /tmp/"
  } */
}

resource "local_file" "splunk-hashi-app" {
  depends_on = [
    null_resource.cleanup
  ]
  source   = "${path.root}/data/splunk/${var.splunk_hashi_app}"
  filename = "${var.path_splunk_hashi_app}/${var.splunk_hashi_app}"
  /* file_permission = "0754" */
  /*   provisioner "local-exec" {
    when    = destroy
    command = "cp -r ${dirname(self.filename)} /tmp/"
  } */
}

resource "local_file" "splunk-config" {
  depends_on = [
    null_resource.cleanup
  ]
  source   = "${path.root}/data/splunk/default.yml"
  filename = "${var.path_splunk_config}/default.yml"
  /* file_permission = "0644" */
  /*   provisioner "local-exec" {
    when    = destroy
    command = "cp -r ${dirname(self.filename)} /tmp/"
  } */
}

resource "local_file" "telegraf-config" {
  depends_on = [
    null_resource.cleanup
  ]
  source          = "${path.root}/data/telegraf/telegraf.conf"
  filename        = "${var.path_telegraf_config}/telegraf.conf"
  file_permission = "0644"
  /*   provisioner "local-exec" {
    when    = destroy
    command = "cp -r ${dirname(self.filename)} /tmp/"
  } */
}

/* resource "local_sensitive_file" "vault-sensitive-file" {
  content  = "bar!"
#  filename = "${path.module}/bar"
  filename = "${var.path_vault_sensitive_file}/bar"
} */

resource "local_file" "vault_s1-config" {
  depends_on = [
    null_resource.cleanup
  ]
  source          = "${path.root}/data/vault/vault_s1/vault-server.hcl"
  filename        = "${var.path_vault_s1_config}/vault-server.hcl"
  file_permission = "0644"
  /*   provisioner "local-exec" {
    when    = destroy
    command = "cp -r ${dirname(self.filename)} /tmp/"
  } */
}

resource "local_file" "vault_s1-ipconfig" {
  depends_on = [
    null_resource.cleanup
  ]
  source          = "${path.root}/data/vault/vault_s1/addr.hcl"
  filename        = "${var.path_vault_s1_config}/addr.hcl"
  file_permission = "0644"
  /*   provisioner "local-exec" {
    when    = destroy
    command = "cp -r ${dirname(self.filename)} /tmp/"
  } */
}

resource "local_file" "vault_s1-data" {
  depends_on = [
    null_resource.cleanup
  ]
  content  = "foobar"
  filename = "${var.path_vault_s1_data}/foo.bar"
  #filename        = "${var.path_vault_data}/s1foo.bar"
  file_permission = "0644"
  /* provisioner "local-exec" {
    when    = destroy
    command = "mv ${dirname(self.filename)} /tmp"
  } */
}

resource "local_file" "vault_s1-license" {
  depends_on = [
    null_resource.cleanup
  ]
  source          = "${path.root}/data/vault/shared/vault.hclic"
  filename        = "${var.path_vault_s1_config}/vault.hclic"
  file_permission = "0444"
  /*   provisioner "local-exec" {
    when    = destroy
    command = "cp -r ${dirname(self.filename)} /tmp/"
  } */
}

resource "local_file" "vault_s1-log" {
  depends_on = [
    null_resource.cleanup
  ]
  content         = "foobar"
  filename        = "${var.path_vault_log}/s1foo.bar"
  file_permission = "0644"
  /* provisioner "local-exec" {
    when    = destroy
    command = "mv ${dirname(self.filename)} /tmp"
  } */
}

resource "local_file" "vault_s2-config" {
  depends_on = [
    null_resource.cleanup
  ]
  source          = "${path.root}/data/vault/vault_s2/vault-server.hcl"
  filename        = "${var.path_vault_s2_config}/vault-server.hcl"
  file_permission = "0644"
  /*   provisioner "local-exec" {
    when    = destroy
    command = "cp -r ${dirname(self.filename)} /tmp/"
  } */
}

resource "local_file" "vault_s2-ipconfig" {
  depends_on = [
    null_resource.cleanup
  ]
  source          = "${path.root}/data/vault/vault_s2/addr.hcl"
  filename        = "${var.path_vault_s2_config}/addr.hcl"
  file_permission = "0644"
  /*   provisioner "local-exec" {
    when    = destroy
    command = "cp -r ${dirname(self.filename)} /tmp/"
  } */
}

resource "local_file" "vault_s2-data" {
  depends_on = [
    null_resource.cleanup
  ]
  content  = "foobar"
  filename = "${var.path_vault_s2_data}/foo.bar"
  #filename        = "${var.path_vault_data}/s2foo.bar"
  file_permission = "0644"
  /* provisioner "local-exec" {
    when    = destroy
    command = "mv ${dirname(self.filename)} /tmp"
  } */
}

resource "local_file" "vault_s2-license" {
  depends_on = [
    null_resource.cleanup
  ]
  source          = "${path.root}/data/vault/shared/vault.hclic"
  filename        = "${var.path_vault_s2_config}/vault.hclic"
  file_permission = "0444"
  /*   provisioner "local-exec" {
    when    = destroy
    command = "cp -r ${dirname(self.filename)} /tmp/"
  } */
}

resource "local_file" "vault_s2-log" {
  depends_on = [
    null_resource.cleanup
  ]
  content         = "foobar"
  filename        = "${var.path_vault_log}/s2foo.bar"
  file_permission = "0644"
  /* provisioner "local-exec" {
    when    = destroy
    command = "mv ${dirname(self.filename)} /tmp"
  } */
}

resource "local_file" "vault_s3-config" {
  depends_on = [
    null_resource.cleanup
  ]
  source          = "${path.root}/data/vault/vault_s3/vault-server.hcl"
  filename        = "${var.path_vault_s3_config}/vault-server.hcl"
  file_permission = "0644"
  /*   provisioner "local-exec" {
    when    = destroy
    command = "cp -r ${dirname(self.filename)} /tmp/"
  } */
}

resource "local_file" "vault_s3-ipconfig" {
  depends_on = [
    null_resource.cleanup
  ]
  source          = "${path.root}/data/vault/vault_s3/addr.hcl"
  filename        = "${var.path_vault_s3_config}/addr.hcl"
  file_permission = "0644"
  /*   provisioner "local-exec" {
    when    = destroy
    command = "cp -r ${dirname(self.filename)} /tmp/"
  } */
}

resource "local_file" "vault_s3-data" {
  depends_on = [
    null_resource.cleanup
  ]
  content  = "foobar"
  filename = "${var.path_vault_s3_data}/foo.bar"
  #filename        = "${var.path_vault_data}/s3foo.bar"
  file_permission = "0644"
  /* provisioner "local-exec" {
    when    = destroy
    command = "mv ${dirname(self.filename)} /tmp"
  } */
}

resource "local_file" "vault_s3-license" {
  depends_on = [
    null_resource.cleanup
  ]
  source          = "${path.root}/data/vault/shared/vault.hclic"
  filename        = "${var.path_vault_s3_config}/vault.hclic"
  file_permission = "0444"
  /*   provisioner "local-exec" {
    when    = destroy
    command = "cp -r ${dirname(self.filename)} /tmp/"
  } */
}

resource "local_file" "vault_s3-log" {
  depends_on = [
    null_resource.cleanup
  ]
  content         = "foobar"
  filename        = "${var.path_vault_log}/s3foo.bar"
  file_permission = "0644"
  /* provisioner "local-exec" {
    when    = destroy
    command = "mv ${dirname(self.filename)} /tmp"
  } */
}

