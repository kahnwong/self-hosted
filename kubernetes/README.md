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
