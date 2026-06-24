# Observability

## Prometheus

```bash
kubectl create namespace prometheus-system

helm repo add prometheus-community oci://ghcr.io/prometheus-community/charts
helm repo update

helm install prometheus prometheus-community/kube-prometheus-stack -f values.yaml -n prometheus-system --create-namespace
```
