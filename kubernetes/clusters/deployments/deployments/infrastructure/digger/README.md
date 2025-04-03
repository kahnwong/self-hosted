# digger

<https://docs.digger.dev/ce/self-host/deploy-helm>

## Setup

```bash
helm repo add digger https://diggerhq.github.io/helm-charts

helm upgrade --install -n infrastructure digger-postgres  ../../../../../charts/base/chart --values digger-postgres.yaml
helm upgrade --install -n infrastructure --create-namespace "digger-backend" digger/digger-backend --values values.yaml
```
