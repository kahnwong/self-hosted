---
title: Kubernetes
---

## Usage
```bash
kubectl proxy

# port forwarding
kubectl port-forward dagster-655484799c-xtlbf 3000:3000
kubectl port-forward service/dagster 3001:3000

# merge kubeconfig
KUBECONFIG=~/.kube/config:~/.kube/k3s_pi kubectl config view --flatten > new

# view contexts
kubectl config get-contexts

# rename context
kubectl config rename-context default k3s_pi
```
