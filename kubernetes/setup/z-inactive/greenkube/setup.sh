#!/bin/bash

helm repo add greenkube https://GreenKubeCloud.github.io/GreenKube
helm repo update

helm upgrade --install greenkube greenkube/greenkube \
  -n greenkube \
  --create-namespace \
  -f values.yaml

kubectl apply -f service.yaml
