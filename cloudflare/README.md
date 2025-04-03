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
| cloudflare | ~> 4.52.0 |
| sops | 1.1.1 |

## Providers

| Name | Version |
|------|---------|
| cloudflare | 4.52.0 |
| sops | 1.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| karnwong\_me | ./modules/cloudflare-pages | n/a |
| karnwong\_me\_dev | ./modules/cloudflare-pages | n/a |
| pages | ./modules/cloudflare-pages | n/a |

## Resources

| Name | Type |
|------|------|
| [cloudflare_api_token.caddy_wildcard_tls](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/api_token) | resource |
| [cloudflare_api_token.ddns_updater](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/api_token) | resource |
| [cloudflare_api_token.deploy_cloudflare_pages](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/api_token) | resource |
| [cloudflare_api_token.r2_backup](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/api_token) | resource |
| [cloudflare_api_token.r2_restic_rw](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/api_token) | resource |
| [cloudflare_api_token.r2_ro](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/api_token) | resource |
| [cloudflare_api_token.r2_send_rw](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/api_token) | resource |
| [cloudflare_page_rule.redirect_www_to_root](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule) | resource |
| [cloudflare_r2_bucket.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/r2_bucket) | resource |
| [cloudflare_record.bluesky_txt](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.github_pages_dns](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.google_workspace_smtp](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.matrix](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.pairdrop](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.pop_mx_send](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.pop_txt_key](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.pop_txt_send](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.selfhosted_dns](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.umami](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.vaultwarden](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.vercel_dns](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_record.www_dummy](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_api_token_permission_groups.all](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/api_token_permission_groups) | data source |
| [sops_file.secrets](https://registry.terraform.io/providers/carlpett/sops/1.1.1/docs/data-sources/file) | data source |

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
| cloudflare\_api\_token\_caddy\_wildcard\_tls | n/a |
| cloudflare\_api\_token\_ddns\_updater | n/a |
| cloudflare\_api\_token\_deploy\_cloudflare\_pages | n/a |
| cloudflare\_api\_token\_r2\_backup | n/a |
| cloudflare\_api\_token\_r2\_restic\_rw | n/a |
| cloudflare\_api\_token\_r2\_ro | n/a |
| cloudflare\_api\_token\_r2\_send\_rw | n/a |
<!-- END_TF_DOCS -->
