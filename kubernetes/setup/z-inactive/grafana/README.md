# Monitoring

## Grafana

```bash
kubectl create namespace monitoring

# base
helm repo add prometheus-community oci://ghcr.io/prometheus-community/charts
helm repo update

helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
    --values grafana.values.yaml \
    --set grafana.defaultDashboardsTimezone="America/Los_Angeles" \
    --namespace monitoring

# blackbox exporter
helm install blackbox-exporter prometheus-community/prometheus-blackbox-exporter \
    --namespace monitoring
```

Grafana `username` is `admin`. Password is obtained via:

```bash
kubectl get secret --namespace monitoring kube-prometheus-stack-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

### Loki

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm install loki grafana/loki \
  --namespace monitoring \
  -f loki.values.yaml
```

### Alloy

```bash
helm install alloy grafana/alloy \
  --values alloy.values.yaml \
  --namespace monitoring
```

### Elasticsearch exporter

```bash
helm install elasticsearch-exporter prometheus-community/prometheus-elasticsearch-exporter \
    --values ./elasticsearch-exporter/values.yaml \
    --namespace monitoring
```

### Postgres exporter

```bash
helm install postgres-exporter prometheus-community/prometheus-postgres-exporter \
    --values ./postgres-exporter/values.yaml \
    --namespace monitoring
```

<!-- ### Mongodb exporter

```bash
helm install mongodb-exporter prometheus-community/prometheus-mongodb-exporter \
    --values ./mongodb-exporter/values.yaml \
    --namespace monitoring
``` -->

### Dashboards

- <https://grafana.com/grafana/dashboards/17594-elasticsearch-index-usage/>
- <https://grafana.com/grafana/dashboards/9628-postgresql-database/>
- <https://grafana.com/grafana/dashboards/12485-postgresql-exporter/>
