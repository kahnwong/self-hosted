#!/bin/bash

helm install prometheus --repo https://prometheus-community.github.io/helm-charts prometheus \
  --namespace prometheus-system --create-namespace \
  --set prometheus-pushgateway.enabled=false \
  --set alertmanager.enabled=false \
  -f https://raw.githubusercontent.com/opencost/opencost/develop/kubernetes/prometheus/extraScrapeConfigs.yaml

helm upgrade --install opencost --repo https://opencost.github.io/opencost-helm-chart opencost \
    --namespace opencost --create-namespace --values values.yaml
