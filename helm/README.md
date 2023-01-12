# helm

Upgrade via `helm upgrade ...`

```bash
helm install supersecretmessage ./charts/supersecretmessage
helm install fava ./charts/fava
helm install komga ./charts/komga
helm install jellyfin ./charts/jellyfin
helm install podgrab ./charts/podgrab
helm install linkding ./charts/linkding
helm install navidrome ./charts/navidrome
helm install miniflux ./charts/miniflux
helm install photoprism ./charts/photoprism
helm install wallabag ./charts/wallabag
```

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
```

## kube-prometheus-stack

```bash
kubectl create namespace kube-prometheus-stack
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# login - admin:prom-operator
helm install kube-prometheus-stack \
    --set grafana.defaultDashboardsTimezone="Asia/Bangkok" \
    --namespace kube-prometheus-stack \
    prometheus-community/kube-prometheus-stack
```

## Sourcegraph (unused)

```bash
kubectl create namespace sourcegraph
helm repo add sourcegraph https://helm.sourcegraph.com/release

helm install \
    --version 4.3.1 \
    --values ./charts/sourcegraph/values.yaml \
    --namespace sourcegraph \
    sourcegraph sourcegraph/sourcegraph
```
