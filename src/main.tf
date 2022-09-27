resource "google_sql_database_instance" "main" {
  provider = google-beta

  name             = var.md_metadata.name_prefix
  region           = "us-central1"
  database_version = "MYSQL_8_0"

  settings {
    backup_configuration {
      enabled = true
    }
    tier = "db-f1-micro"
    ip_configuration {
      require_ssl     = true
      ipv4_enabled    = false
      private_network = var.gcp_subnetwork.data.infrastructure.gcp_global_network_grn
    }
  }
}

