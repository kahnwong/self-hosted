# snikt

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.6 |
| kubernetes | 2.22.0 |
| sops | 0.7.2 |

## Providers

| Name | Version |
|------|---------|
| kubernetes | 2.22.0 |
| sops | 0.7.2 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/namespace) | resource |
| [kubernetes_secret.harbor_config](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/secret) | resource |
| [kubernetes_secret.this](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/secret) | resource |
| [sops_file.this](https://registry.terraform.io/providers/carlpett/sops/0.7.2/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_certificate | n/a | `string` | n/a | yes |
| client\_key | n/a | `string` | n/a | yes |
| cluster\_ca\_certificate | n/a | `string` | n/a | yes |
| host | n/a | `string` | n/a | yes |
| registry\_password | n/a | `string` | n/a | yes |
| registry\_server | n/a | `string` | n/a | yes |
| registry\_username | n/a | `string` | n/a | yes |
<!-- END_TF_DOCS -->
