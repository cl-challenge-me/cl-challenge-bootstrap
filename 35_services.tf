resource "google_project_service" "services" {
  project                    = var.provisioner_project_id
  for_each                   = toset([
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",

  ])
  service                    = each.key
  disable_dependent_services = true
}