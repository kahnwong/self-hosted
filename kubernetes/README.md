# Kubernetes

Upgrade via `helm upgrade ...`

## Notes

- Syncthing doesn't play nice with Kubernetes, need to set permissions via init container

## Apps

```bash
helm install fava ./default/base --values fava.yaml
```

## Packaging helm chart

```bash
helm package $CHART
helm registry login registry.karnwong.me -u $USER
helm push demo-0.1.0.tgz oci://registry.karnwong.me/helm

# usage
helm install <my-release> oci://registry.karnwong.me/charts/base
```
