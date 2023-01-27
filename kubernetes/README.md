# Kubernetes

Upgrade via `helm upgrade ...`

## Apps

```bash
helm install fava ./base --values fava.yaml
helm install jellyfin ./base --values jellyfin.yaml
helm install komga ./base --values komga.yaml
helm install linkding ./base --values linkding.yaml
helm install miniflux ./app/miniflux
helm install navidrome ./base --values navidrome.yaml
helm install photoprism ./base --values photoprism.yaml
helm install podgrab ./base --values podgrab.yaml
helm install sourcegraph ./base --values sourcegraph.yaml
helm install sourcegraph-mfec ./base --values sourcegraph-mfec.yaml
helm install sourcegraph-personal ./base --values sourcegraph-personal.yaml
helm install supersecretmessage ./base --values supersecretmessage.yaml
helm install tileserver ./base --values tileserver.yaml
helm install transmission ./base --values transmission.yaml
helm install wallabag ./app/wallabag
```

## Monitoring

### Grafana agent

<https://grafana.com/docs/grafana-cloud/kubernetes-monitoring/configuration/config-k8s-agent-guide/>

- For `configmap.yaml`, in `grafana-agent` and `grafana-logs-agent`, obtain it from the [Kubernetes integrations UI].

```bash
kubectl create namespace monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install grafana-agent ./monitoring/grafana-agent -n monitoring
helm install ksm prometheus-community/kube-state-metrics --set image.tag=v2.4.2 -n monitoring
helm install nodeexporter prometheus-community/prometheus-node-exporter -n monitoring

helm install grafana-logs-agent ./monitoring/grafana-logs-agent -n monitoring
```

<!-- ### Grafana agent operator

```bash
kubectl create namespace monitoring

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana-agent-operator grafana/grafana-agent-operator -n monitoring
``` -->

Then follow instructions in <https://grafana.com/docs/grafana-cloud/kubernetes-monitoring/configuration/config-k8s-agent-operator-guide/>.

### Dashboards

- <https://grafana.com/grafana/dashboards/17594-elasticsearch-index-usage/>
- <https://grafana.com/grafana/dashboards/9628-postgresql-database/>
- <https://grafana.com/grafana/dashboards/12485-postgresql-exporter/>
- <https://grafana.com/grafana/dashboards/14928-prometheus-blackbox-exporter/>

#### Opencost

<https://www.opencost.io/docs/install>

```bash
kubectl create namespace opencost

helm install prometheus prometheus-community/prometheus \
  --values ./opencost/prometheus/values.yaml \
  --namespace opencost

helm install opencost ./opencost/opencost --namespace opencost
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
