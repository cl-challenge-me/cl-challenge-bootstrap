locals {
  sa_mapping = merge({
    for e in var.env_list : "provisioner-sa-${e}-app-nginx-hello" => {
      sa_name   = "projects/${var.provisioner_project_id}/serviceAccounts/${google_service_account.provisioner_sa["${e}"].email}"
      attribute = "attribute.repository/${var.github_org}/cl-challenge-app-nginx-hello"
    }
  },
  {
    for e in var.env_list : "provisioner-sa-${e}-infra" => {
      sa_name   = "projects/${var.provisioner_project_id}/serviceAccounts/${google_service_account.provisioner_sa["${e}"].email}"
      attribute = "attribute.repository/${var.github_org}/cl-challenge-infra"
    }
  })
}

module "gh_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = var.provisioner_project_id
  pool_id     = "github-pool"
  provider_id = "github-provider"
  sa_mapping  = local.sa_mapping
}