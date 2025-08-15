# Configmaps


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.6 |
| helm | 3.0.2 |
| kubernetes | 2.38.0 |
| sops | 1.2.1 |

## Providers

| Name | Version |
|------|---------|
| helm | 3.0.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.jobs](https://registry.terraform.io/providers/hashicorp/helm/3.0.2/docs/resources/release) | resource |
| [helm_release.jobs_fringe_division](https://registry.terraform.io/providers/hashicorp/helm/3.0.2/docs/resources/release) | resource |
| [helm_release.jobs_livegrep](https://registry.terraform.io/providers/hashicorp/helm/3.0.2/docs/resources/release) | resource |

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
