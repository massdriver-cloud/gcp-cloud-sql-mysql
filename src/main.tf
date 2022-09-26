resource "google_sql_database_instance" "main" {
  provider = google-beta

  name             = var.md_metadata.name_prefix
  region           = "us-central1"
  database_version = "MYSQL_8_0"

  # depends_on = [google_service_networking_connection.private_vpc_connection]

  # require_ssl = true

  settings {
    backup_configuration {
      enabled = true
    }
    tier = "db-f1-micro"
    ip_configuration {
      require_ssl     = true
      ipv4_enabled    = false
      private_network = var.gcp_global_network.data.grn
    }
  }
}

# resource "google_sql_user" "users" {
#   name     = "me"
#   instance = google_sql_database_instance.main.name
#   host     = "me.com"
#   password = "changeme"
# }


