# Secrets


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
| [kubernetes_secret_v1.ghcr_config](https://registry.terraform.io/providers/hashicorp/kubernetes/3.0.1/docs/resources/secret_v1) | resource |
| [kubernetes_secret_v1.secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/3.0.1/docs/resources/secret_v1) | resource |
| [sops_file.secrets](https://registry.terraform.io/providers/carlpett/sops/1.4.1/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | n/a | `string` | n/a | yes |
| ghcr\_namespaces | n/a | `set(string)` | n/a | yes |
| ghcr\_token | n/a | `string` | n/a | yes |
| ghcr\_username | n/a | `string` | n/a | yes |
| secrets | n/a | `map(list(string))` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
