# Jobs


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| helm | 3.1.1 |

## Providers

| Name | Version |
|------|---------|
| helm | 3.1.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/3.1.1/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| chart\_name | n/a | `string` | n/a | yes |
| chart\_version | n/a | `string` | n/a | yes |
| jobs | n/a | `map(list(string))` | n/a | yes |
| values\_extras | n/a | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
