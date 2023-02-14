resource "google_service_account" "provisioner_sa" {
  for_each     = toset(var.env_list)
  account_id   = "provisioner-sa-${each.key}"
  display_name = "Provisioner SA for ${each.key}"
}

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