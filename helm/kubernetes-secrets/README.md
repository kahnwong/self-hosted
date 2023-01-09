# kubernetes-secrets

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name       | Version  |
| ---------- | -------- |
| terraform  | >= 1.3.6 |
| helm       | 2.8.0    |
| kubernetes | 2.16.1   |

## Providers

| Name       | Version |
| ---------- | ------- |
| helm       | 2.8.0   |
| kubernetes | 2.16.1  |

## Resources

| Name                                                                                                                                       | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| [helm_release.kube_prometheus_stack](https://registry.terraform.io/providers/hashicorp/helm/2.8.0/docs/resources/release)                  | resource |
| [helm_release.kubernetes_dashboard](https://registry.terraform.io/providers/hashicorp/helm/2.8.0/docs/resources/release)                   | resource |
| [kubernetes_namespace.kube_prometheus_stack](https://registry.terraform.io/providers/hashicorp/kubernetes/2.16.1/docs/resources/namespace) | resource |
| [kubernetes_namespace.kubernetes_dashboard](https://registry.terraform.io/providers/hashicorp/kubernetes/2.16.1/docs/resources/namespace)  | resource |

## Inputs

| Name                   | Description | Type     | Default | Required |
| ---------------------- | ----------- | -------- | ------- | :------: |
| client_certificate     | n/a         | `string` | n/a     |   yes    |
| client_key             | n/a         | `string` | n/a     |   yes    |
| cluster_ca_certificate | n/a         | `string` | n/a     |   yes    |
| host                   | n/a         | `string` | n/a     |   yes    |

<!-- END_TF_DOCS -->
