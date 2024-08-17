# snikt

## Run this by hand

```bash
kubectl taint nodes fringe-division storage-required=true:NoSchedule
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.6 |
| helm | 2.12.1 |
| kubernetes | 2.25.2 |
| sops | 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| helm | 2.12.1 |
| kubernetes | 2.25.2 |
| sops | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.fringe_division](https://registry.terraform.io/providers/hashicorp/helm/2.12.1/docs/resources/release) | resource |
| [helm_release.jobs](https://registry.terraform.io/providers/hashicorp/helm/2.12.1/docs/resources/release) | resource |
| [helm_release.jobs_fringe_division](https://registry.terraform.io/providers/hashicorp/helm/2.12.1/docs/resources/release) | resource |
| [helm_release.livegrep_indexer](https://registry.terraform.io/providers/hashicorp/helm/2.12.1/docs/resources/release) | resource |
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/2.12.1/docs/resources/release) | resource |
| [kubernetes_cluster_role.deployment_restart](https://registry.terraform.io/providers/hashicorp/kubernetes/2.25.2/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.pod_exec](https://registry.terraform.io/providers/hashicorp/kubernetes/2.25.2/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.deployment_restart](https://registry.terraform.io/providers/hashicorp/kubernetes/2.25.2/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.pod_exec](https://registry.terraform.io/providers/hashicorp/kubernetes/2.25.2/docs/resources/cluster_role_binding) | resource |
| [kubernetes_config_map.configmaps](https://registry.terraform.io/providers/hashicorp/kubernetes/2.25.2/docs/resources/config_map) | resource |
| [kubernetes_manifest.qa_discord_bot](https://registry.terraform.io/providers/hashicorp/kubernetes/2.25.2/docs/resources/manifest) | resource |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/2.25.2/docs/resources/namespace) | resource |
| [kubernetes_secret.deployment_restart](https://registry.terraform.io/providers/hashicorp/kubernetes/2.25.2/docs/resources/secret) | resource |
| [kubernetes_secret.pod_exec](https://registry.terraform.io/providers/hashicorp/kubernetes/2.25.2/docs/resources/secret) | resource |
| [kubernetes_secret.secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/2.25.2/docs/resources/secret) | resource |
| [kubernetes_service_account.deployment_restart](https://registry.terraform.io/providers/hashicorp/kubernetes/2.25.2/docs/resources/service_account) | resource |
| [kubernetes_service_account.pod_exec](https://registry.terraform.io/providers/hashicorp/kubernetes/2.25.2/docs/resources/service_account) | resource |
| [sops_file.configmaps](https://registry.terraform.io/providers/carlpett/sops/1.0.0/docs/data-sources/file) | data source |
| [sops_file.livegrep](https://registry.terraform.io/providers/carlpett/sops/1.0.0/docs/data-sources/file) | data source |
| [sops_file.secrets](https://registry.terraform.io/providers/carlpett/sops/1.0.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_certificate | n/a | `string` | n/a | yes |
| client\_key | n/a | `string` | n/a | yes |
| cluster\_ca\_certificate | n/a | `string` | n/a | yes |
| host | n/a | `string` | n/a | yes |
<!-- END_TF_DOCS -->
