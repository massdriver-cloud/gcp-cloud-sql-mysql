locals {
  data_infrastructure = {
    name = google_sql_database_instance.main.name
  }

  # https://github.com/massdriver-cloud/artifact-definitions/blob/main/definitions/artifacts/mysql-authentication.json
  data_authentication = {
    username = google_sql_user.root.name
    password = google_sql_user.root.password
    hostname = google_sql_database_instance.main.private_ip_address
    port     = 3306
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
        version = tostring(google_sql_database_instance.main.settings[0].version)
      }
    }
  }
}

resource "massdriver_artifact" "authentication" {
  field    = "authentication"
  name     = "'Root' SQL user credentials for: ${google_sql_database_instance.main.self_link}"
  artifact = jsonencode(local.artifact)
}
