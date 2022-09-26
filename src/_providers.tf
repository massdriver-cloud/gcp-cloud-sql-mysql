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

provider "google" {
  project     = var.gcp_authentication.data.project_id
  credentials = jsonencode(var.gcp_authentication.data)
  # region      = var.mrc.specs.gcp.region
}

provider "google-beta" {
  project     = var.gcp_authentication.data.project_id
  credentials = jsonencode(var.gcp_authentication.data)
  # region      = var.mrc.specs.gcp.region
}
