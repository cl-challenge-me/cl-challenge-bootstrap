resource "google_storage_bucket" "tfstate" {
  for_each = toset(var.env_list)
  name     = "${var.tfstate_bucket_base_name}-${each.key}"
  location = var.location
  versioning {
    enabled = true
  }
}