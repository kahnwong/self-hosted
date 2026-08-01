# coroot

<https://docs.coroot.com/>

```bash
helm repo add coroot https://coroot.github.io/helm-charts
helm repo update coroot

helm install -n coroot --create-namespace coroot-operator coroot/coroot-operator
```

## In-memory Prometheus and ClickHouse

This keeps Prometheus and ClickHouse data in memory-backed `emptyDir` volumes.
Data is lost when pods are deleted or rescheduled.

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# Prometheus: native chart support for memory-backed emptyDir.
helm upgrade --install prometheus prometheus-community/prometheus \
  --namespace coroot \
  --set alertmanager.enabled=false \
  --set prometheus-pushgateway.enabled=false \
  --set kube-state-metrics.enabled=false \
  --set prometheus-node-exporter.enabled=false \
  --set server.persistentVolume.enabled=false \
  --set server.emptyDir.medium=Memory \
  --set server.emptyDir.sizeLimit=8Gi \
  --set server.retention=6h \
  --set 'server.extraArgs.web\.enable-remote-write-receiver=null'

# ClickHouse: disable PVCs first, then patch the generated emptyDir data
# volume to use RAM. Re-run the patch after Helm upgrades.
helm upgrade --install clickhouse bitnami/clickhouse \
  --namespace coroot \
  --set shards=2 \
  --set replicaCount=2 \
  --set auth.username=default \
  --set auth.password=clickhouse \
  --set persistence.enabled=false \
  --set keeper.persistence.enabled=false

for sts in $(kubectl -n coroot get sts \
  -l app.kubernetes.io/instance=clickhouse \
  -o name); do
  kubectl -n coroot patch "$sts" --type strategic \
    -p '{"spec":{"template":{"spec":{"volumes":[{"name":"data","emptyDir":{"medium":"Memory","sizeLimit":"20Gi"}}]}}}}'
  kubectl -n coroot rollout restart "$sts"
done
```

Install Coroot and point it at those external services:

```bash
helm upgrade --install coroot coroot/coroot-ce \
  --namespace coroot \
  --set externalPrometheus.url=http://prometheus-server.coroot.svc.cluster.local:80 \
  --set externalPrometheus.remoteWriteURL=http://prometheus-server.coroot.svc.cluster.local:80/api/v1/write \
  --set externalClickhouse.address=clickhouse.coroot.svc.cluster.local:9000 \
  --set externalClickhouse.user=default \
  --set externalClickhouse.password=clickhouse \
  --set externalClickhouse.database=default

# port-forward
kubectl port-forward -n coroot service/coroot-coroot 8080:8080
```

## Add traces

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm upgrade --install beyla grafana/beyla \
  --values beyla.values.yaml \
  --namespace observability
```
