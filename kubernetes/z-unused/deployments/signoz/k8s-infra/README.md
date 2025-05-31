# K8S Infra

For monitoring Kubernetes

## Setup

```bash
helm install -n signoz-k8s-infra --create-namespace "signoz-k8s-infra" signoz/k8s-infra --values values.yaml

```

## Refs
- <https://signoz.io/docs/tutorial/kubernetes-infra-metrics/>
