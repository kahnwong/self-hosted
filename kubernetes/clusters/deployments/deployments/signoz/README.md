# Signoz

<https://signoz.io/docs/operate/kubernetes/>

```bash
helm repo add signoz https://charts.signoz.io
helm install -n signoz --create-namespace "signoz" signoz/signoz --values values.yaml

# upgrade
helm upgrade --install -n signoz --create-namespace "signoz" signoz/signoz --values values.yaml
```
