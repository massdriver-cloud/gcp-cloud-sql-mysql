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
    certificate = {
      cert = google_sql_database_instance.main.server_ca_cert[0].cert
    }
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
  name                 = "a contextual name for the artifact"
  artifact             = jsonencode(local.artifact)
}
