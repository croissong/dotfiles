terraform {
  required_providers {
    outlook = {
      source  = "magodo/outlook"
      version = "0.0.4"
    }

    google = {
      source  = "hashicorp/google"
      version = "4.40.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "2.30.0"
    }

    sops = {
      source  = "lokkersp/sops"
      version = "0.6.9"
    }
  }

  required_version = ">= 1.3"
}


provider "sops" {}

provider "outlook" {}

provider "google" {}

provider "azuread" {
  tenant_id = "a30e38d1-62f2-4b94-aea8-f5ae261fd880"
}

