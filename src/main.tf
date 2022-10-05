locals {
  # Cloud SQL expects the Global VPC GRN
  network_id = var.gcp_subnetwork.data.infrastructure.gcp_global_network_grn
  # These are internal sane defaults
  massdriver_maitenance_window_day   = "Tuesday"
  massdriver_maintenance_window_hour = 2
  maintenance_window_day_human_readable_to_terraform = {
    "Monday"    = 1
    "Tuesday"   = 2
    "Wednesday" = 3
    "Thursday"  = 4
    "Friday"    = 5
    "Saturday"  = 6
    "Sunday"    = 7
  }
  maintenance_window_day  = lookup(local.maintenance_window_day_human_readable_to_terraform, local.massdriver_maitenance_window_day, null)
  maintenance_window_hour = local.massdriver_maintenance_window_hour
}

resource "google_sql_database_instance" "main" {
  # checkov:skip=CKV_GCP_6: TODO: link issue
  provider = google-beta

  name             = var.md_metadata.name_prefix
  region           = local.gcp_region
  database_version = var.engine_version

  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
  # On newer versions of the provider, you must explicitly set
  # deletion_protection=false (and run terraform apply to write the field to state) in order
  # to destroy an instance. It is recommended to not set this field (or set it to true)
  # until you're ready to destroy the instance and its databases.
  deletion_protection = var.deletion_protection

  settings {
    tier              = var.instance_configuration.tier
    activation_policy = "ALWAYS"
    availability_type = "REGIONAL"
    user_labels       = var.md_metadata.default_tags

    ip_configuration {
      require_ssl     = false
      ipv4_enabled    = false
      private_network = local.network_id
    }

    backup_configuration {
      # cannot be used with PostgreSQL
      binary_log_enabled             = true
      enabled                        = true
      transaction_log_retention_days = var.transaction_log_retention_days

      backup_retention_settings {
        retained_backups = var.database_configuration.retained_backup_count
        # if the unit is COUNT then the above is number of backups to keep
        retention_unit = "COUNT"
      }
    }

    insights_config {
      query_insights_enabled = var.database_configuration.query_insights_enabled
      # double the default
      query_string_length     = 2000
      record_application_tags = false
      record_client_address   = false
    }

    disk_autoresize = false
    disk_size       = var.instance_configuration.disk_size
    disk_type       = var.instance_configuration.disk_type
    # TF docs say this is the only option for pricing_plan
    pricing_plan = "PER_USE"

    maintenance_window {
      day          = local.maintenance_window_day
      hour         = local.maintenance_window_hour
      update_track = "stable"
    }
  }

  lifecycle {
    ignore_changes = [
      # We might want to gaurd against this and disable auto resize
      # then remove this lifecycle hook
      settings[0].disk_size,
      # ignores changes to existing infrastructure
      settings[0].ip_configuration[0].require_ssl,
    ]
  }
}

resource "random_password" "root_user_password" {
  length  = 10
  special = false
}

resource "google_sql_user" "root" {
  depends_on = [google_sql_database_instance.main]
  project    = local.gcp_project
  name       = var.username
  instance   = google_sql_database_instance.main.name
  password = random_password.root_user_password.result
}
