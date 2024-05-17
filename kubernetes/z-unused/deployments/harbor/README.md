# Harbor

```bash
kubectl create namespace harbor
helm upgrade --install harbor oci://registry-1.docker.io/bitnamicharts/harbor --namespace harbor --values values.yaml
```
