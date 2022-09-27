terraform {
  required_version = ">= 1.0"
  required_providers {
    massdriver = {
      source  = "massdriver-cloud/massdriver"
      version = "~> 1.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.0"
    }
  }
}

locals {
  gcp_region = var.gcp_subnetwork.specs.gcp.region
}

provider "google" {
  project     = var.gcp_authentication.data.project_id
  credentials = jsonencode(var.gcp_authentication.data)
  region      = local.gcp_region
}

provider "google-beta" {
  project     = var.gcp_authentication.data.project_id
  credentials = jsonencode(var.gcp_authentication.data)
  region      = local.gcp_region
}
