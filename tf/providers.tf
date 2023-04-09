terraform {
  required_providers {
    outlook = {
      source  = "magodo/outlook"
      version = "0.5.0"
    }

    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "2.33.0"
    }

    sops = {
      source  = "lokkersp/sops"
      version = "0.6.10"
    }
  }

  required_version = ">= 1.3"
}


provider "sops" {}

provider "outlook" {}

provider "google" {}

provider "azuread" {
  tenant_id = "dc6fe035-d1b7-4fe5-b9f5-8a84d1fe06ae"
}
