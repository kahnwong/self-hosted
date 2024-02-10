# tf-cloudflare


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| cloudflare | ~> 4.24.0 |
| sops | 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| cloudflare | 4.24.0 |
| sops | 1.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| docs | ./modules/cloudflare-pages | n/a |
| h3\_viewer | ./modules/cloudflare-pages | n/a |
| jupyterlite | ./modules/cloudflare-pages | n/a |
| karnwong\_me | ./modules/cloudflare-pages | n/a |
| retriever | ./modules/cloudflare-pages | n/a |
| slc | ./modules/cloudflare-pages | n/a |

## Resources

| Name | Type |
|------|------|
| [cloudflare_page_rule.redirect_www_to_root](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule) | resource |
| [cloudflare_record.pop_mx_send](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.pop_txt_key](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.pop_txt_send](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.selfhosted_dns](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.terraform_managed_resource_143555b19652cd46080796d693da123e](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.terraform_managed_resource_453c42c73366d4a6878e501f564ba2b8](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.terraform_managed_resource_46e88ec4e3f8942732a3a9c25ee4f83c](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.terraform_managed_resource_989f8a3455d739ec043a6e073c70a1bb](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.vaultwarden](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
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
