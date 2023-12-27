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

## Resources

| Name | Type |
|------|------|
| [kubernetes_secret.harbor_config](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/secret) | resource |

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
