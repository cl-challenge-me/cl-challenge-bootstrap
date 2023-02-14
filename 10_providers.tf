terraform {
  required_providers {
    google = "=4.52.0"
  }
}

provider "google" {
  project = var.provisioner_project_id
}