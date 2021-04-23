terraform {
  required_providers {
    outlook = {
      source = "magodo/outlook"
    }

    google = {
      source  = "hashicorp/google"
      version = "3.65.0"
    }
  }
}

provider "outlook" {}

variable "google_access_token" {
  type      = string
  sensitive = true
}

provider "google" {
  access_token = var.google_access_token
}
