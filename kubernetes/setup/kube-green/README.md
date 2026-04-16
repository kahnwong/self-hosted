# kube-green

```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.20.2/cert-manager.yaml

helm repo add kube-green https://kube-green.github.io/helm-charts/
helm install kube-green kube-green/kube-green --namespace kube-green --create-namespace
```
