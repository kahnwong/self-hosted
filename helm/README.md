# helm

Upgrade via `helm upgrade ...`

## Apps

```bash
helm install fava ./app/fava
helm install jellyfin ./app/jellyfin
helm install komga ./app/komga
helm install linkding ./app/linkding
helm install miniflux ./app/miniflux
helm install navidrome ./app/navidrome
helm install photoprism ./app/photoprism
helm install podgrab ./app/podgrab
helm install sourcegraph ./app/sourcegraph
helm install supersecretmessage ./app/supersecretmessage
helm install tileserver ./app/tileserver
helm install wallabag ./app/wallabag
```

## Monitoring

### Dashboards

- <https://grafana.com/grafana/dashboards/17594-elasticsearch-index-usage/>
- <https://grafana.com/grafana/dashboards/9628-postgresql-database/>
- <https://grafana.com/grafana/dashboards/12485-postgresql-exporter/>
- <https://grafana.com/grafana/dashboards/14928-prometheus-blackbox-exporter/>

<!-- #### Opencost

<https://www.opencost.io/docs/install>

```bash
helm install opencost ./monitoring/opencost --namespace monitoring
``` -->

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
