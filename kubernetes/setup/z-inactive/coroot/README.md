# coroot

<https://docs.coroot.com/>

```bash
helm repo add coroot https://coroot.github.io/helm-charts
helm repo update coroot

helm install -n coroot --create-namespace coroot-operator coroot/coroot-operator

helm install -n coroot coroot coroot/coroot-ce \
  --set "clickhouse.shards=2,clickhouse.replicas=2"

# port-forward
kubectl port-forward -n coroot service/coroot-coroot 8080:8080
```
