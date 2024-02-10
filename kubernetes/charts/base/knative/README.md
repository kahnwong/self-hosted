# Knative

<https://knative.dev/docs/install/operator/knative-with-operators/>

```bash
kubectl apply -f https://github.com/knative/operator/releases/download/knative-v1.12.0/operator.yaml --namespace default
kubectl apply -f knative-serving.yaml
kubectl apply -f https://github.com/knative/net-kourier/releases/download/knative-v1.0.0/kourier.yaml

# verify that it works
kubectl --namespace knative-serving get service kourier
kubectl get deployment -n knative-serving
kubectl get KnativeServing knative-serving -n knative-serving
```
