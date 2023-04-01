#!/bin/bash

namespace="opencost"

pod_name=$(kubectl get pods --namespace "$namespace" | grep opencost | awk '{print $1}')
kubectl port-forward "$pod_name" 9090:9090 --namespace "$namespace"
