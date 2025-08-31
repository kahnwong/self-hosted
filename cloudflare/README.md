# tf-cloudflare

Required token permissions: <https://github.com/cloudflare/cloudflare-docs/issues/12777#issuecomment-1946954852>

```bash
xxxxxxx's Account - Cloudflare Pages:Edit, Workers R2 Storage:Edit
    All zones - Page Rules:Edit, DNS:Edit
All users - API Tokens:Edit
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| cloudflare | 5.9.0 |
| sops | 1.2.1 |

## Providers

| Name | Version |
|------|---------|
| cloudflare | 5.9.0 |
| sops | 1.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| karnwong\_me | ./modules/cloudflare-pages | n/a |
| karnwong\_me\_dev | ./modules/cloudflare-pages | n/a |
| pages | ./modules/cloudflare-pages | n/a |

## Resources

| Name | Type |
|------|------|
| [cloudflare_api_token.caddy_wildcard_tls](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/api_token) | resource |
| [cloudflare_api_token.ddns_updater](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/api_token) | resource |
| [cloudflare_api_token.deploy_cloudflare_pages](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/api_token) | resource |
| [cloudflare_api_token.r2_backup](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/api_token) | resource |
| [cloudflare_api_token.r2_restic_rw](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/api_token) | resource |
| [cloudflare_api_token.r2_ro](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/api_token) | resource |
| [cloudflare_api_token.r2_send_rw](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/api_token) | resource |
| [cloudflare_api_token.r2_terraform_state_rw](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/api_token) | resource |
| [cloudflare_dns_record.bluesky_txt](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.gcp_dns](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.github_pages_dns](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.google_workspace_smtp](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.oracle_dns](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.pop_mx_send](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.pop_txt_key](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.pop_txt_send](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.selfhosted_dns](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.vercel_dns](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.www_dummy](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/dns_record) | resource |
| [cloudflare_page_rule.redirect_www_to_root](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/page_rule) | resource |
| [cloudflare_r2_bucket.this](https://registry.terraform.io/providers/cloudflare/cloudflare/5.9.0/docs/resources/r2_bucket) | resource |
| [sops_file.secrets](https://registry.terraform.io/providers/carlpett/sops/1.2.1/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloudflare\_account\_id | n/a | `string` | n/a | yes |
| cloudflare\_api\_token | n/a | `string` | n/a | yes |
| cloudflare\_zone\_id | n/a | `string` | n/a | yes |
| private\_dns | n/a | `set(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cloudflare\_api\_token\_ddns\_updater | n/a |
| cloudflare\_api\_token\_deploy\_cloudflare\_pages | n/a |
<!-- END_TF_DOCS -->
