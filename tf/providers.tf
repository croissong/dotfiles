terraform {
  required_providers {
    outlook = {
      source  = "magodo/outlook"
      version = "0.0.4"
    }

    google = {
      source  = "hashicorp/google"
      version = "4.4.0"
    }
  }

  required_version = ">= 1.1.0"
}


provider "outlook" {}



provider "google" {}
