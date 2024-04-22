# tf-github

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.2.7 |
| github | 6.2.1 |
| sops | 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| github | 6.2.1 |
| sops | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [github_actions_secret.cloudflare_pages](https://registry.terraform.io/providers/integrations/github/6.2.1/docs/resources/actions_secret) | resource |
| [github_actions_secret.docs_algolia](https://registry.terraform.io/providers/integrations/github/6.2.1/docs/resources/actions_secret) | resource |
| [sops_file.secrets](https://registry.terraform.io/providers/carlpett/sops/1.0.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| github\_token | need for github auth | `string` | n/a | yes |
<!-- END_TF_DOCS -->
