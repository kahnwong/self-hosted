# tf-cloudflare


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| cloudflare | ~> 3.34.0 |
| sops | 0.7.1 |

## Providers

| Name | Version |
|------|---------|
| cloudflare | 3.34.0 |
| sops | 0.7.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| docs | ./modules/cloudflare-pages | n/a |
| karnwong\_me | ./modules/cloudflare-pages | n/a |

## Resources

| Name | Type |
|------|------|
| [cloudflare_page_rule.redirect_to_www](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule) | resource |
| [cloudflare_record.github_pages_dns](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.root_dummy](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.selfhosted_dns](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.smtp_a](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.smtp_b](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.smtp_c](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.smtp_d](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.smtp_e](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.standardnotes_listed](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.terraform_managed_resource_143555b19652cd46080796d693da123e](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.terraform_managed_resource_453c42c73366d4a6878e501f564ba2b8](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.terraform_managed_resource_46e88ec4e3f8942732a3a9c25ee4f83c](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.terraform_managed_resource_989f8a3455d739ec043a6e073c70a1bb](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [sops_file.secrets](https://registry.terraform.io/providers/carlpett/sops/0.7.1/docs/data-sources/file) | data source |
<!-- END_TF_DOCS -->
