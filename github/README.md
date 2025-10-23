# tf-github

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.2.7 |
| github | 6.6.0 |
| sops | 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| github | 6.6.0 |
| sops | 1.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_actions_secret.cloudflare_pages](https://registry.terraform.io/providers/integrations/github/6.6.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.docs_algolia](https://registry.terraform.io/providers/integrations/github/6.6.0/docs/resources/actions_secret) | resource |
| [github_actions_secret.vercel](https://registry.terraform.io/providers/integrations/github/6.6.0/docs/resources/actions_secret) | resource |
| [sops_file.secrets](https://registry.terraform.io/providers/carlpett/sops/1.3.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| github\_token | need for github auth | `string` | n/a | yes |
| private\_cloudflare\_pages\_repos | n/a | `set(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
