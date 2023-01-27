# Monitoring

## kubernetes-dashboard

```bash
kubectl create namespace kubernetes-dashboard
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/

helm install kubernetes-dashboard \
    --set metricsScraper.enabled=true \
    --set metricsServer.enabled=true \
    --set replicaCount=1 \
    --set rbac.clusterReadOnlyRole=true \
    --namespace kubernetes-dashboard \
    kubernetes-dashboard/kubernetes-dashboard

# get dashboard token
kubectl -n kubernetes-dashboard create token kubernetes-dashboard | pbcopy
```

## kube-prometheus-stack

### Base

```bash
kubectl create namespace monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# login - admin:prom-operator
helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
    --values ./monitoring/kube-prometheus-stack/values.yaml \
    --set grafana.defaultDashboardsTimezone="Asia/Bangkok" \
    --namespace monitoring
```

### Blackbox exporter

```bash
helm install blackbox-exporter prometheus-community/prometheus-blackbox-exporter \
    --namespace monitoring
```

### Elasticsearch exporter

```bash
helm install elasticsearch-exporter prometheus-community/prometheus-elasticsearch-exporter \
    --values ./monitoring/elasticsearch-exporter/values.yaml \
    --namespace monitoring
```

### Postgres exporter

```bash
helm install postgres-exporter prometheus-community/prometheus-postgres-exporter \
    --values ./monitoring/postgres-exporter/values.yaml \
    --namespace monitoring
```

<!-- ### Mongodb exporter

```bash
helm install mongodb-exporter prometheus-community/prometheus-mongodb-exporter \
    --values ./monitoring/mongodb-exporter/values.yaml \
    --namespace monitoring
``` -->
