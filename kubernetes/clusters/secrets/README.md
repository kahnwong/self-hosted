# Secrets


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.6 |
| kubernetes | 2.33.0 |
| sops | 1.1.1 |

## Providers

| Name | Version |
|------|---------|
| kubernetes | 2.33.0 |
| sops | 1.1.1 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_secret.secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/2.33.0/docs/resources/secret) | resource |
| [sops_file.secrets](https://registry.terraform.io/providers/carlpett/sops/1.1.1/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_certificate | n/a | `string` | n/a | yes |
| client\_key | n/a | `string` | n/a | yes |
| cluster\_ca\_certificate | n/a | `string` | n/a | yes |
| host | n/a | `string` | n/a | yes |
<!-- END_TF_DOCS -->


```bash
terraform state mv \
    -state=terraform.tfstate \
    -state-out=../jobs/terraform.tfstate \
    helm_release.livegrep_indexer \
    helm_release.livegrep_indexer
#terraform state push dev.tfstate
```