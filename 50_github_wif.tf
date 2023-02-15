locals {
  sa_mapping = {
    for e in var.env_list : "provisioner-sa-${e}" => {
      sa_name   = "projects/${var.provisioner_project_id}/serviceAccounts/${google_service_account.provisioner_sa["${e}"].email}"
      attribute = "attribute.repository/${var.github_user_org}/*"
    }
  }
}

module "gh_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = var.provisioner_project_id
  pool_id     = "github-pool"
  provider_id = "github-provider"
  sa_mapping  = local.sa_mapping
}