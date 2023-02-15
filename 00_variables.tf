variable "provisioner_project_id" {
  default     = "provisioner-377821"
  description = "Provisioner project ID"
}

variable "tfstate_bucket_base_name" {
  default     = "cl-challenge"
  description = "Terraform state bucket base name"
}

variable "location" {
  default     = "EU"
  description = "Terraform multi-region bucket location"
}

variable "parent_folder" {
  default     = "folders/593280390575"
  description = "Root folder for environmental folders"
}

variable "github_user_org" {
  default     = "pavelrn/cl-challenge-me"
  description = "Github orhanization"
}

variable "env_list" {
  default     = ["dev", "stage", "prod"]
  description = "Environments list"
}

