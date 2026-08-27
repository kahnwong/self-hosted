# Kueue

<https://kueue.sigs.k8s.io/>

## Setup

```bash
kubectl apply --server-side -f https://github.com/kubernetes-sigs/kueue/releases/download/v0.19.2/manifests.yaml

kubectl apply -f quick-start-setup.yaml

# verify
kubectl get clusterqueue cluster-queue -o wide
kubectl get localqueue user-queue -n default

# submit job
kubectl apply -f quick-start-job.yaml

# observe job
kubectl get workloads -n default
```
