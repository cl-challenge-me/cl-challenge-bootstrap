output "buckets" {
  value = [for k, v in google_storage_bucket.tfstate : v.id]
}


output "folders" {
  value = { for k, v in google_folder.envs : k => v.id }
}