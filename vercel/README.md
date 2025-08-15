# tf-vercel


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| sops | 1.2.1 |
| vercel | 3.10.0 |

## Providers

| Name | Version |
|------|---------|
| sops | 1.2.0 |
| vercel | 3.10.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vercel_project.shouldideploytoday](https://registry.terraform.io/providers/vercel/vercel/3.10.0/docs/resources/project) | resource |
| [vercel_project.transform](https://registry.terraform.io/providers/vercel/vercel/3.10.0/docs/resources/project) | resource |
| [vercel_project_domain.shouldideploytoday](https://registry.terraform.io/providers/vercel/vercel/3.10.0/docs/resources/project_domain) | resource |
| [vercel_project_domain.transform](https://registry.terraform.io/providers/vercel/vercel/3.10.0/docs/resources/project_domain) | resource |
| [sops_file.secrets](https://registry.terraform.io/providers/carlpett/sops/1.2.1/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vercel\_token | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
