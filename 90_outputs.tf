output "buckets" {
  value = [for k, v in google_storage_bucket.tfstate : v.name]
}