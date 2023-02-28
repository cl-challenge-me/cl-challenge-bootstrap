resource "google_folder" "envs" {
  for_each     = toset(var.env_list)
  display_name = each.key
  parent       = var.parent_folder
}

resource "google_folder" "env-infra" {
  for_each     = toset(var.env_list)
  display_name = "infrastructure"
  parent       = google_folder.envs[each.key].id
}

resource "google_folder" "env-apps" {
  for_each     = toset(var.env_list)
  display_name = "applications"
  parent       = google_folder.envs[each.key].id
}