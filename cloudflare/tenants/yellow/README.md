# yellow


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| cloudflare | 5.24.0 |
| sops | 1.4.1 |

## Providers

| Name | Version |
| ---- | ------- |
| cloudflare | 5.24.0 |
| sops | 1.4.1 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| card\_a | ../../modules/cloudflare-pages | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [cloudflare_dns_record.mx](https://registry.terraform.io/providers/cloudflare/cloudflare/5.24.0/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.txt](https://registry.terraform.io/providers/cloudflare/cloudflare/5.24.0/docs/resources/dns_record) | resource |
| [sops_file.secrets](https://registry.terraform.io/providers/carlpett/sops/1.4.1/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| card\_a\_domain\_name | n/a | `string` | n/a | yes |
| card\_a\_project\_name | card\_a | `string` | n/a | yes |
| card\_a\_subdomain | n/a | `string` | n/a | yes |
| cloudflare\_account\_id | n/a | `string` | n/a | yes |
| cloudflare\_api\_token | n/a | `string` | n/a | yes |
| cloudflare\_zone\_id | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
