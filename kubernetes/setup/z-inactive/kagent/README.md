# kagent

<https://kagent.dev/docs/kagent/getting-started/quickstart/>

## Setup

```bash
helm install kagent-crds oci://ghcr.io/kagent-dev/kagent/helm/kagent-crds \
    --namespace kagent \
    --create-namespace

helm install kagent oci://ghcr.io/kagent-dev/kagent/helm/kagent \
    --namespace kagent \
    --set providers.default=openAI \
    --set providers.openAI.apiKey="dummy"
```

Access via:

```bash
kubectl port-forward -n kagent svc/kagent-ui 8080:8080  # <http://localhost:8080>
```
