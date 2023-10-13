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
    --values ./kube-prometheus-stack/values.yaml \
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

### Dashboards

- <https://grafana.com/grafana/dashboards/17594-elasticsearch-index-usage/>
- <https://grafana.com/grafana/dashboards/9628-postgresql-database/>
- <https://grafana.com/grafana/dashboards/12485-postgresql-exporter/>
- <https://grafana.com/grafana/dashboards/14928-prometheus-blackbox-exporter/>

## coroot

<https://github.com/coroot/coroot>

```bash
helm repo add coroot https://coroot.github.io/helm-charts
helm repo update

helm install --namespace coroot --create-namespace coroot coroot/coroot
```

## ddosify

<https://github.com/ddosify/alaz>

```bash
helm repo add ddosify https://ddosify.github.io/ddosify-helm-charts/
helm repo update

kubectl create namespace ddosify
helm upgrade --install --namespace ddosify ddosify ddosify/ddosify --wait

# Add a cluster on the Observability page of your Self-Hosted frontend. You will receive a Monitoring ID and instructions.

export MONITORING_ID=xxxxxxxxxx
export BACKEND_HOST=http://backend.ddosify.svc.cluster.local:8008
helm upgrade --install --namespace ddosify alaz ddosify/alaz --set monitoringID=$MONITORING_ID --set backendHost=$BACKEND_HOST
```

## cilium

<https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/#k8s-install-quick>

Don't forget to set custom CNI during k8s installation.

```bash
## on local
cilium install --version 1.14.2
cilium hubble enable
cilium hubble enable --ui

# open ui
cilium hubble ui

# test hubble
## if pod fails run this on linux host
sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl fs.inotify.max_user_instances=512

while true; do cilium connectivity test; done
```
