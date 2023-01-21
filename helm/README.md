# helm

Upgrade via `helm upgrade ...`

## Apps

```bash
helm install supersecretmessage ./app/supersecretmessage
helm install fava ./app/fava
helm install komga ./app/komga
helm install jellyfin ./app/jellyfin
helm install podgrab ./app/podgrab
helm install linkding ./app/linkding
helm install navidrome ./app/navidrome
helm install miniflux ./app/miniflux
helm install photoprism ./app/photoprism
helm install wallabag ./app/wallabag
helm install sourcegraph ./app/sourcegraph
helm install tileserver ./app/tileserver
```

## Monitoring

### kubernetes-dashboard

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
```

### kube-prometheus-stack

#### Base

```bash
kubectl create namespace monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# login - admin:prom-operator
helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
    --values ./monitoring/kube-prometheus-stack/values.yaml \
    --set grafana.defaultDashboardsTimezone="Asia/Bangkok" \
    --namespace monitoring
```

#### Blackbox exporter

```bash
helm install blackbox-exporter prometheus-community/prometheus-blackbox-exporter \
    --namespace monitoring
```

#### Elasticsearch exporter

```bash
helm install elasticsearch-exporter prometheus-community/prometheus-elasticsearch-exporter \
    --values ./monitoring/elasticsearch-exporter/values.yaml \
    --namespace monitoring
```

#### Postgres exporter

```bash
helm install postgres-exporter prometheus-community/prometheus-postgres-exporter \
    --values ./monitoring/postgres-exporter/values.yaml \
    --namespace monitoring
```

## Misc

### Sourcegraph (official helm chart, unused)

```bash
kubectl create namespace sourcegraph
helm repo add sourcegraph https://helm.sourcegraph.com/release

helm install \
    --version 4.3.1 \
    --values ./charts/sourcegraph/values.yaml \
    --namespace sourcegraph \
    sourcegraph sourcegraph/sourcegraph
```
