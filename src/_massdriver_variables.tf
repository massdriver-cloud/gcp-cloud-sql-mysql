// Auto-generated variable declarations from massdriver.yaml
variable "database_configuration" {
  type = object({
    high_availability_enabled = bool
    query_insights_enabled    = bool
    retained_backup_count     = number
  })
}
variable "deletion_protection" {
  type = bool
}
variable "engine_version" {
  type = string
}
variable "gcp_authentication" {
  type = object({
    data = object({
      auth_provider_x509_cert_url = string
      auth_uri                    = string
      client_email                = string
      client_id                   = string
      client_x509_cert_url        = string
      private_key                 = string
      private_key_id              = string
      project_id                  = string
      token_uri                   = string
      type                        = string
    })
    specs = object({
      gcp = optional(object({
        project = optional(string)
        region  = optional(string)
      }))
    })
  })
}
variable "gcp_subnetwork" {
  type = object({
    data = object({
      infrastructure = object({
        cidr                   = string
        gcp_global_network_grn = string
        grn                    = string
        vpc_access_connector   = string
      })
    })
    specs = object({
      gcp = optional(object({
        project = optional(string)
        region  = optional(string)
      }))
    })
  })
}
variable "instance_configuration" {
  type = object({
    disk_size = number
    disk_type = string
    tier      = string
  })
}
variable "md_metadata" {
  type = object({
    default_tags = object({
      managed-by  = string
      md-manifest = string
      md-package  = string
      md-project  = string
      md-target   = string
    })
    deployment = object({
      id = string
    })
    name_prefix = string
    observability = object({
      alarm_webhook_url = string
    })
    package = object({
      created_at             = string
      deployment_enqueued_at = string
      previous_status        = string
      updated_at             = string
    })
    target = object({
      contact_email = string
    })
  })
}
variable "transaction_log_retention_days" {
  type = number
}
variable "username" {
  type = string
}
