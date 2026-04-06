# Secrets


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.6 |
| kubernetes | 3.0.1 |
| sops | 1.4.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| secrets | ../../../modules/secrets | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_certificate | n/a | `string` | n/a | yes |
| client\_key | n/a | `string` | n/a | yes |
| cluster\_ca\_certificate | n/a | `string` | n/a | yes |
| cluster\_name | n/a | `string` | `"r440"` | no |
| ghcr\_token | n/a | `string` | n/a | yes |
| ghcr\_username | n/a | `string` | n/a | yes |
| host | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->


```bash
terraform state mv \
    -state=terraform.tfstate \
    -state-out=../jobs/terraform.tfstate \
    helm_release.livegrep_indexer \
    helm_release.livegrep_indexer
#terraform state push dev.tfstate
```
