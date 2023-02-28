# What is it?
It is a boostrap logic that for each environment (dev, stage and prod):
- creates Terraform state buckets
- creates provisioner SA in provisioner project
- creates project folders for each environment and for each project type (applications, infrastructure)
- grants provisioner SA permissions to edit the environment
- configures Workload Id Federation for Github to access GCP

# How to use?
1. Create provisioner project and link it to the billing account manually
2. Create root folder
2. Fill out the `00_variables.tf` file variables
3. Run Terraform
```
terraform init
terraform plan
terraform apply
```

# Details
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | =4.52.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.52.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gh_oidc"></a> [gh\_oidc](#module\_gh\_oidc) | terraform-google-modules/github-actions-runners/google//modules/gh-oidc | n/a |

## Resources

| Name | Type |
|------|------|
| [google_billing_account_iam_binding.binding](https://registry.terraform.io/providers/hashicorp/google/4.52.0/docs/resources/billing_account_iam_binding) | resource |
| [google_folder.env-apps](https://registry.terraform.io/providers/hashicorp/google/4.52.0/docs/resources/folder) | resource |
| [google_folder.env-infra](https://registry.terraform.io/providers/hashicorp/google/4.52.0/docs/resources/folder) | resource |
| [google_folder.envs](https://registry.terraform.io/providers/hashicorp/google/4.52.0/docs/resources/folder) | resource |
| [google_folder_iam_policy.env_access](https://registry.terraform.io/providers/hashicorp/google/4.52.0/docs/resources/folder_iam_policy) | resource |
| [google_project_iam_binding.bucket-custom-access](https://registry.terraform.io/providers/hashicorp/google/4.52.0/docs/resources/project_iam_binding) | resource |
| [google_project_iam_binding.storage-creator](https://registry.terraform.io/providers/hashicorp/google/4.52.0/docs/resources/project_iam_binding) | resource |
| [google_project_iam_binding.storage-viewer](https://registry.terraform.io/providers/hashicorp/google/4.52.0/docs/resources/project_iam_binding) | resource |
| [google_project_iam_custom_role.bucket-custom-access](https://registry.terraform.io/providers/hashicorp/google/4.52.0/docs/resources/project_iam_custom_role) | resource |
| [google_project_service.services](https://registry.terraform.io/providers/hashicorp/google/4.52.0/docs/resources/project_service) | resource |
| [google_service_account.provisioner_sa](https://registry.terraform.io/providers/hashicorp/google/4.52.0/docs/resources/service_account) | resource |
| [google_storage_bucket.tfstate](https://registry.terraform.io/providers/hashicorp/google/4.52.0/docs/resources/storage_bucket) | resource |
| [google_iam_policy.access](https://registry.terraform.io/providers/hashicorp/google/4.52.0/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | Billing account ID | `string` | `"011168-59E2C9-06B012"` | no |
| <a name="input_env_list"></a> [env\_list](#input\_env\_list) | Environments list | `list` | <pre>[<br>  "dev",<br>  "stage",<br>  "prod"<br>]</pre> | no |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | Github orhanization | `string` | `"cl-challenge-me"` | no |
| <a name="input_location"></a> [location](#input\_location) | Terraform multi-region bucket location | `string` | `"EU"` | no |
| <a name="input_parent_folder"></a> [parent\_folder](#input\_parent\_folder) | Root folder for environmental folders | `string` | `"folders/593280390575"` | no |
| <a name="input_provisioner_project_id"></a> [provisioner\_project\_id](#input\_provisioner\_project\_id) | Provisioner project ID | `string` | `"provisioner-377821"` | no |
| <a name="input_tfstate_bucket_base_name"></a> [tfstate\_bucket\_base\_name](#input\_tfstate\_bucket\_base\_name) | Terraform state bucket base name | `string` | `"cl-challenge"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_buckets"></a> [buckets](#output\_buckets) | n/a |
| <a name="output_folders"></a> [folders](#output\_folders) | n/a |
<!-- END_TF_DOCS -->