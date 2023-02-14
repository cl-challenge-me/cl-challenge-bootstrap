resource "google_folder" "envs" {
  for_each     = toset(var.env_list)
  display_name = each.key
  parent       = var.parent_folder
}