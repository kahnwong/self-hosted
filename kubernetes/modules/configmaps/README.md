# Configmaps


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| kubernetes | 3.0.1 |
| sops | 1.4.1 |

## Providers

| Name | Version |
|------|---------|
| kubernetes | 3.0.1 |
| sops | 1.4.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map_v1.configmaps](https://registry.terraform.io/providers/hashicorp/kubernetes/3.0.1/docs/resources/config_map_v1) | resource |
| [sops_file.configmaps](https://registry.terraform.io/providers/carlpett/sops/1.4.1/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | n/a | `string` | n/a | yes |
| configmaps | n/a | ```map(list(object({ source = string filename = string input_type = optional(string) })))``` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
