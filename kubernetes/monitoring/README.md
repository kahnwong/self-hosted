# Grafana agent

<https://grafana.com/docs/grafana-cloud/kubernetes-monitoring/configuration/config-k8s-agent-guide/>

- For `configmap.yaml`, in `grafana-agent` and `grafana-logs-agent`, obtain it from the [Kubernetes integrations UI].

```bash
kubectl create namespace monitoring
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana-agent-operator grafana/grafana-agent-operator -n monitoring
kubectl apply -f ./monitoring/grafana-agent-operator/values.yaml -n monitoring
```
