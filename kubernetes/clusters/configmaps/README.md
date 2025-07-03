# Configmaps


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.6 |
| kubernetes | 2.37.1 |
| sops | 1.2.0 |

## Providers

| Name | Version |
|------|---------|
| kubernetes | 2.37.1 |
| sops | 1.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map.configmaps](https://registry.terraform.io/providers/hashicorp/kubernetes/2.37.1/docs/resources/config_map) | resource |
| [kubernetes_config_map.evcc](https://registry.terraform.io/providers/hashicorp/kubernetes/2.37.1/docs/resources/config_map) | resource |
| [kubernetes_config_map.garage](https://registry.terraform.io/providers/hashicorp/kubernetes/2.37.1/docs/resources/config_map) | resource |
| [kubernetes_config_map.livegrep-config](https://registry.terraform.io/providers/hashicorp/kubernetes/2.37.1/docs/resources/config_map) | resource |
| [sops_file.configmaps](https://registry.terraform.io/providers/carlpett/sops/1.2.0/docs/data-sources/file) | data source |
| [sops_file.evcc](https://registry.terraform.io/providers/carlpett/sops/1.2.0/docs/data-sources/file) | data source |
| [sops_file.garage](https://registry.terraform.io/providers/carlpett/sops/1.2.0/docs/data-sources/file) | data source |
| [sops_file.livegrep-config](https://registry.terraform.io/providers/carlpett/sops/1.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_certificate | n/a | `string` | n/a | yes |
| client\_key | n/a | `string` | n/a | yes |
| cluster\_ca\_certificate | n/a | `string` | n/a | yes |
| host | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
