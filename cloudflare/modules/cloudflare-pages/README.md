# Cloudflare Pages

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| cloudflare | 5.6.0 |

## Providers

| Name | Version |
|------|---------|
| cloudflare | 5.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_dns_record.this](https://registry.terraform.io/providers/cloudflare/cloudflare/5.6.0/docs/resources/dns_record) | resource |
| [cloudflare_pages_domain.this](https://registry.terraform.io/providers/cloudflare/cloudflare/5.6.0/docs/resources/pages_domain) | resource |
| [cloudflare_pages_project.this](https://registry.terraform.io/providers/cloudflare/cloudflare/5.6.0/docs/resources/pages_project) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | n/a | `string` | n/a | yes |
| domain\_name | n/a | `string` | n/a | yes |
| production\_branch | n/a | `string` | `"master"` | no |
| project\_name | n/a | `string` | n/a | yes |
| subdomain | n/a | `string` | n/a | yes |
| zone\_id | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
