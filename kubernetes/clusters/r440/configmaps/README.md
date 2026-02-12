# Configmaps


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.6 |
| kubernetes | 3.0.1 |
| sops | 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| kubernetes | 3.0.1 |
| sops | 1.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map_v1.garage](https://registry.terraform.io/providers/hashicorp/kubernetes/3.0.1/docs/resources/config_map_v1) | resource |
| [sops_file.garage](https://registry.terraform.io/providers/carlpett/sops/1.3.0/docs/data-sources/file) | data source |

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
