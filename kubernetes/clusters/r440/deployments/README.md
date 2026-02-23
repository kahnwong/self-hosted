# r440-deployments

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.6 |
| helm | 3.1.1 |
| kubectl | ~> 2.0 |
| kubernetes | 3.0.1 |

## Providers

| Name | Version |
|------|---------|
| helm | 3.1.1 |
| kubernetes | 3.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/3.1.1/docs/resources/release) | resource |
| [kubernetes_namespace_v1.this](https://registry.terraform.io/providers/hashicorp/kubernetes/3.0.1/docs/resources/namespace_v1) | resource |

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
