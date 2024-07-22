# tf-cloudflare


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| cloudflare | ~> 4.35.0 |
| sops | 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| cloudflare | 4.35.0 |
| sops | 1.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| karnwong\_me | ./modules/cloudflare-pages | n/a |
| pages | ./modules/cloudflare-pages | n/a |

## Resources

| Name | Type |
|------|------|
| [cloudflare_page_rule.redirect_www_to_root](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule) | resource |
| [cloudflare_record.github_pages_dns](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.google_workspace_smtp](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.pop_mx_send](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.pop_txt_key](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.pop_txt_send](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.selfhosted_dns](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.vaultwarden](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.vercel_dns](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.www_dummy](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [sops_file.secrets](https://registry.terraform.io/providers/carlpett/sops/1.0.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloudflare\_account\_id | n/a | `string` | n/a | yes |
| cloudflare\_api\_token | n/a | `string` | n/a | yes |
| cloudflare\_zone\_id | n/a | `string` | n/a | yes |
| private\_dns | n/a | `set(string)` | n/a | yes |
<!-- END_TF_DOCS -->
