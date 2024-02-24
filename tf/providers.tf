terraform {
  required_providers {
    outlook = {
      source  = "magodo/outlook"
      version = "0.5.0"
    }

    google = {
      source  = "hashicorp/google"
      version = "5.17.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "2.47.0"
    }

    sops = {
      # https://github.com/carlpett/terraform-provider-sops/issues/50
      source  = "lokkersp/sops"
      version = "0.6.10"
    }

    b2 = {
      source  = "Backblaze/b2"
      version = "0.8.9"
    }
  }

  required_version = ">= 1.7"
}


provider "sops" {}

provider "outlook" {}

provider "google" {}

provider "azuread" {
  tenant_id = "dc6fe035-d1b7-4fe5-b9f5-8a84d1fe06ae"
}

provider "b2" {}
