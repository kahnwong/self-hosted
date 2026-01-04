# deployments

## Helm chart dev

```bash
helm upgrade --install slash ../../charts/base/chart --values deployments/tools/slash.yaml --namespace tools
```

## Run this by hand

```bash
kubectl taint nodes fringe-division storage-required=true:NoSchedule
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.6 |
| helm | 3.1.1 |
| kubectl | ~> 2.0 |
| kubernetes | 2.38.0 |
| sops | 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| helm | 3.1.1 |
| kubernetes | 2.38.0 |
| sops | 1.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.authentik](https://registry.terraform.io/providers/hashicorp/helm/3.1.1/docs/resources/release) | resource |
| [helm_release.fringe_division](https://registry.terraform.io/providers/hashicorp/helm/3.1.1/docs/resources/release) | resource |
| [helm_release.harbor](https://registry.terraform.io/providers/hashicorp/helm/3.1.1/docs/resources/release) | resource |
| [helm_release.knative](https://registry.terraform.io/providers/hashicorp/helm/3.1.1/docs/resources/release) | resource |
| [helm_release.misc](https://registry.terraform.io/providers/hashicorp/helm/3.1.1/docs/resources/release) | resource |
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/3.1.1/docs/resources/release) | resource |
| [kubernetes_cluster_role.deployment_restart](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.pod_exec](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.deployment_restart](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.pod_exec](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/cluster_role_binding) | resource |
| [kubernetes_manifest.notes_personal](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/manifest) | resource |
| [kubernetes_manifest.notes_sync](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/manifest) | resource |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/namespace) | resource |
| [kubernetes_secret.deployment_restart](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/secret) | resource |
| [kubernetes_secret.pod_exec](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/secret) | resource |
| [kubernetes_service_account.deployment_restart](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/service_account) | resource |
| [kubernetes_service_account.pod_exec](https://registry.terraform.io/providers/hashicorp/kubernetes/2.38.0/docs/resources/service_account) | resource |
| [sops_file.misc](https://registry.terraform.io/providers/carlpett/sops/1.3.0/docs/data-sources/file) | data source |

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

## Outputs

No outputs.
<!-- END_TF_DOCS -->
