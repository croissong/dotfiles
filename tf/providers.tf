terraform {
  required_providers {
    outlook = {
      source  = "magodo/outlook"
      version = "0.0.4"
    }

    google = {
      source  = "hashicorp/google"
      version = "4.29.0"
    }
  }

  required_version = ">= 1.2"
}


provider "outlook" {}



provider "google" {}
