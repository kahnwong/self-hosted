# Signoz

## Setup
```bash
helm repo add signoz https://charts.signoz.io
helm install -n signoz --create-namespace "signoz" signoz/signoz --values values.yaml

# upgrade
helm upgrade --install -n signoz --create-namespace "signoz" signoz/signoz --values values.yaml
```

## Deploy sample app
```bash
curl -sL https://github.com/SigNoz/signoz/raw/develop/sample-apps/hotrod/hotrod-install.sh \
  | HELM_RELEASE=signoz SIGNOZ_NAMESPACE=signoz bash

# generate load
kubectl --namespace sample-application run strzal --image=djbingham/curl \
  --restart='OnFailure' -i --tty --rm --command -- curl -X POST -F \
  'user_count=6' -F 'spawn_rate=2' http://locust-master:8089/swarm

# stop load generation
kubectl -n sample-application run strzal --image=djbingham/curl \
  --restart='OnFailure' -i --tty --rm --command -- curl \
  http://locust-master:8089/stop
```


## Refs
- <https://signoz.io/docs/install/kubernetes/others/>
- <https://signoz.io/docs/operate/kubernetes/>
