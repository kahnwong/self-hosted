# tf-kubernetes

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
| [kubernetes_cluster_role.readonly](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.readonly](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/cluster_role_binding) | resource |
| [kubernetes_secret.foo](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/secret) | resource |
| [kubernetes_secret.harbor_config](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/secret) | resource |
| [kubernetes_secret.llm](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/secret) | resource |
| [kubernetes_secret.miniflux](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/secret) | resource |
| [kubernetes_secret.minio](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/secret) | resource |
| [kubernetes_secret.photoprism](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/secret) | resource |
| [kubernetes_secret.picoshare](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/secret) | resource |
| [kubernetes_service_account.foo](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/service_account) | resource |
| [sops_file.llm](https://registry.terraform.io/providers/carlpett/sops/0.7.2/docs/data-sources/file) | data source |
| [sops_file.miniflux](https://registry.terraform.io/providers/carlpett/sops/0.7.2/docs/data-sources/file) | data source |
| [sops_file.minio](https://registry.terraform.io/providers/carlpett/sops/0.7.2/docs/data-sources/file) | data source |
| [sops_file.photoprism](https://registry.terraform.io/providers/carlpett/sops/0.7.2/docs/data-sources/file) | data source |
| [sops_file.picoshare](https://registry.terraform.io/providers/carlpett/sops/0.7.2/docs/data-sources/file) | data source |

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
