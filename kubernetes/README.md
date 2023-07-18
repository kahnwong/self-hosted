# Kubernetes

Upgrade via `helm upgrade ...`

## Notes

- Syncthing doesn't play nice with Kubernetes

## Apps

```bash
helm install fava ./default/base --values fava.yaml
```

## Harbor

```bash
kubectl create namespace harbor
helm install harbor oci://registry-1.docker.io/bitnamicharts/harbor --namespace harbor --values ./harbor/values.yaml
```

## Monitoring

### Grafana agent

<https://grafana.com/docs/grafana-cloud/kubernetes-monitoring/configuration/config-k8s-agent-guide/>

- For `configmap.yaml`, in `grafana-agent` and `grafana-logs-agent`, obtain it from the [Kubernetes integrations UI].

```bash
kubectl create namespace monitoring
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana-agent-operator grafana/grafana-agent-operator -n monitoring
kubectl apply -f ./monitoring/grafana-agent-operator/values.yaml -n monitoring
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

## Opencost

<https://www.opencost.io/docs/install>

```bash
kubectl create namespace opencost

helm install prometheus prometheus-community/prometheus \
  --values ./opencost/prometheus/values.yaml \
  --namespace opencost

# https://raw.githubusercontent.com/opencost/opencost/develop/kubernetes/opencost.yaml
kubectl apply --namespace opencost -f ./opencost/opencost/opencost.yaml
```

## coroot

<https://github.com/coroot/coroot>

```bash
helm repo add coroot https://coroot.github.io/helm-charts
helm repo update

helm install --namespace coroot --create-namespace coroot coroot/coroot
```

## GitOps (unused)

- [guide](https://fluxcd.io/flux/get-started/)
- [bootstrap with terraform](https://fluxcd.io/flux/installation/#bootstrap-with-terraform)

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
