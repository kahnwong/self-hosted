# Cloudflare Pages

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| cloudflare | 4.45.0 |

## Providers

| Name | Version |
|------|---------|
| cloudflare | 4.44.0 |

## Resources

| Name | Type |
|------|------|
| [cloudflare_pages_domain.this](https://registry.terraform.io/providers/cloudflare/cloudflare/4.45.0/docs/resources/pages_domain) | resource |
| [cloudflare_pages_project.this](https://registry.terraform.io/providers/cloudflare/cloudflare/4.45.0/docs/resources/pages_project) | resource |
| [cloudflare_record.this](https://registry.terraform.io/providers/cloudflare/cloudflare/4.45.0/docs/resources/record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | n/a | `string` | n/a | yes |
| domain\_name | n/a | `string` | n/a | yes |
| production\_branch | n/a | `string` | `"master"` | no |
| project\_name | n/a | `string` | n/a | yes |
| subdomain | n/a | `string` | n/a | yes |
| zone\_id | n/a | `string` | n/a | yes |
<!-- END_TF_DOCS -->