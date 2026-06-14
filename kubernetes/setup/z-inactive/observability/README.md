# Observability

## Grafana

```bash
kubectl create namespace observability

helm repo add prometheus-community oci://ghcr.io/prometheus-community/charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add grafana-community oci://ghcr.io/grafana-community/helm-charts
helm repo update

# base
helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
  --values grafana.values.yaml \
  --set grafana.defaultDashboardsTimezone="America/Los_Angeles" \
  --namespace observability

# blackbox exporter
helm upgrade --install blackbox-exporter prometheus-community/prometheus-blackbox-exporter \
  --namespace observability
```

Grafana `username` is `admin`. Password is obtained via:

```bash
kubectl get secret --namespace observability kube-prometheus-stack-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

### Loki

```bash
helm upgrade --install loki grafana-community/loki \
  --namespace observability \
  -f loki.values.yaml
```

### Tempo

```bash
helm upgrade --install tempo grafana-community/tempo \
  --values tempo.values.yaml \
  --namespace observability
```

### Alloy

```bash
helm upgrade --install alloy grafana/alloy \
  --values alloy.values.yaml \
  --namespace observability
```

### Beyla

```bash
helm upgrade --install beyla grafana/beyla \
  --values beyla.values.yaml \
  --namespace observability
```

## Robusta

```bash
kubectl create namespace monitoring

helm repo add robusta https://robusta-charts.storage.googleapis.com
helm repo update
helm upgrade --install robusta robusta/robusta -n monitoring -f robusta.values.yaml
```
