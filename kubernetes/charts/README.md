# Kubernetes

Upgrade via `helm upgrade ...`

## Notes

- Syncthing doesn't play nice with Kubernetes, need to set permissions via init container

## Apps

```bash
helm install fava ./base/chart --values fava.yaml
```

## Packaging helm chart

```bash
helm package base/chart
helm registry login harbor.karnwong.me -u $USER
helm push base-0.1.0.tgz oci://harbor.karnwong.me/charts

# usage
helm install <my-release> oci://harbor.karnwong.me/charts/base
```
