# Configmaps


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.6 |
| kubernetes | 2.33.0 |
| sops | 1.1.1 |

## Providers

| Name | Version |
|------|---------|
| kubernetes | 2.33.0 |
| sops | 1.1.1 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map.configmaps](https://registry.terraform.io/providers/hashicorp/kubernetes/2.33.0/docs/resources/config_map) | resource |
| [kubernetes_config_map.livegrep-ignorelist](https://registry.terraform.io/providers/hashicorp/kubernetes/2.33.0/docs/resources/config_map) | resource |
| [kubernetes_config_map.plausible_clickhouse_config](https://registry.terraform.io/providers/hashicorp/kubernetes/2.33.0/docs/resources/config_map) | resource |
| [kubernetes_config_map.plausible_clickhouse_user_config](https://registry.terraform.io/providers/hashicorp/kubernetes/2.33.0/docs/resources/config_map) | resource |
| [sops_file.configmaps](https://registry.terraform.io/providers/carlpett/sops/1.1.1/docs/data-sources/file) | data source |
| [sops_file.livegrep-ignorelist](https://registry.terraform.io/providers/carlpett/sops/1.1.1/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_certificate | n/a | `string` | n/a | yes |
| client\_key | n/a | `string` | n/a | yes |
| cluster\_ca\_certificate | n/a | `string` | n/a | yes |
| host | n/a | `string` | n/a | yes |
<!-- END_TF_DOCS -->
