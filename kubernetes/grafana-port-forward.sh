#!/bin/bash

namespace="monitoring"

pod_name=$(kubectl get pods --namespace "$namespace" | grep grafana | awk '{print $1}')
kubectl port-forward "$pod_name" 3000:3000 --namespace "$namespace"
