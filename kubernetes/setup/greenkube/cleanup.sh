export NAMESPACE=greenkube
kubectl get ns $NAMESPACE -o json | jq '.spec.finalizers = []' | kubectl replace --raw "/api/v1/namespaces/$NAMESPACE/finalize" -f -
