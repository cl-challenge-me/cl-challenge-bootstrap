resource "google_service_account" "provisioner_sa" {
  for_each     = toset(var.env_list)
  account_id   = "provisioner-sa-${each.key}"
  display_name = "Provisioner SA for ${each.key}"
}

# Billing account access
resource "google_billing_account_iam_binding" "binding" {
  billing_account_id = var.billing_account
  role               = "roles/billing.user"
  members = [
    for sa in google_service_account.provisioner_sa: "serviceAccount:${sa.email}"
  ]
}

# ENV editor access
resource "google_folder_iam_policy" "env_access" {
  for_each    = toset(var.env_list)
  folder      = google_folder.envs[each.key].id
  policy_data = data.google_iam_policy.access[each.key].policy_data
}

data "google_iam_policy" "access" {
  for_each = toset(var.env_list)
  binding {
    role = "roles/editor"

    members = [
      "serviceAccount:${google_service_account.provisioner_sa[each.key].email}",
    ]
  }
}

# TF state bucket access
resource "google_project_iam_custom_role" "bucket-custom-access" {
  project = var.provisioner_project_id
  role_id     = "bucketCustomAccess"
  title       = "Cloud Storage Bucket Custom Access"
  description = "Cloud Storage bucket custom access permissions"
  permissions = [
    "storage.objects.delete"
  ]
}

resource "google_project_iam_binding" "bucket-custom-access" {
  project = var.provisioner_project_id
  role = google_project_iam_custom_role.bucket-custom-access.id
  members = [
    for sa in google_service_account.provisioner_sa: "serviceAccount:${sa.email}"
  ]
}

resource "google_project_iam_binding" "storage-viewer" {
  project = var.provisioner_project_id
  role = "roles/storage.objectViewer"
  members = [
    for sa in google_service_account.provisioner_sa: "serviceAccount:${sa.email}"
  ]
}

resource "google_project_iam_binding" "storage-creator" {
  project = var.provisioner_project_id
  role = "roles/storage.objectCreator"
  members = [
    for sa in google_service_account.provisioner_sa: "serviceAccount:${sa.email}"
  ]
}