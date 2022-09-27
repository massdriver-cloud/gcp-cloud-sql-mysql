locals {
  data_infrastructure = {
    name = google_sql_database_instance.main.name
  }

  # https://github.com/massdriver-cloud/artifact-definitions/blob/main/definitions/artifacts/mysql-authentication.json
  data_authentication = {
    username = ""
    password = ""
    hostname = google_sql_database_instance.main.private_ip_address
    port     = ""
    certificate = var.tls_enabled ? {
      cert             = google_sql_database_instance.main.server_ca_cert[0].cert
      create_time      = google_sql_database_instance.main.server_ca_certs[0].create_time
      expiration_time  = google_sql_database_instance.main.server_ca_certs[0].expiration_time
      sha1_fingerprint = google_sql_database_instance.main.server_ca_certs[0].sha1_fingerprint
    } : null
  }

  artifact = {
    data = {
      infrastructure = local.data_infrastructure
      authentication = local.data_authentication
      security = {
      }
    }
    specs = {
      rdbms = {
        engine  = "mysql"
        version = google_sql_database_instance.main.settings[0].version
      }
    }
  }
}

resource "massdriver_artifact" "authentication" {
  field                = "authentication"
  provider_resource_id = google_sql_database_instance.main.id
  name                 = "'Root' SQL user credentials for: ${google_sql_database_instance.main.self_link}"
  artifact             = jsonencode(local.artifact)
}
