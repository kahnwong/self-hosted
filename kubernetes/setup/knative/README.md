# Knative

- <https://knative.dev/docs/install/yaml-install/serving/install-serving-with-yaml/#install-the-knative-serving-component>
- <https://knative.dev/blog/articles/set-up-a-local-knative-environment-with-kind/>

```bash
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.19.6/serving-crds.yaml
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.19.6/serving-core.yaml
```

Modify kourier to use nodePort

```bash
wget https://github.com/knative/net-kourier/releases/download/knative-v1.19.5/kourier.yaml
```

```yaml
spec:
  ports:
    - name: http2
      port: 80
      protocol: TCP
      targetPort: 8080
      nodePort: 31080
    - name: https
      port: 443
      protocol: TCP
      targetPort: 8443
      nodePort: 31443
  selector:
    app: 3scale-kourier-gateway
  type: NodePort
```

```bash
kubectl apply -f kourier.yaml
```

```bash
# set Kourier as default networking layer
kubectl patch configmap/config-network \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"ingress-class":"kourier.ingress.networking.knative.dev"}}'

# patch dns
kubectl patch configmap/config-domain \
      --namespace knative-serving \
      --type merge \
      --patch '{"data":{"example.com":""}}'

# validate
kubectl describe configmap/config-domain --namespace knative-serving
kubectl --namespace kourier-system get service kourier  # use output for reverse-proxy port later
kubectl get pods -n knative-serving

# test
cat > service.yaml <<EOF
apiVersion: serving.knative.dev/v1 # Current version of Knative
kind: Service
metadata:
  name: helloworld-go # The name of the app
  namespace: default # The namespace the app will use
spec:
  template:
    spec:
      containers:
        - image: ghcr.io/knative/helloworld-go:latest # The URL to the image of the app
          env:
            - name: TARGET # The environment variable printed out by the sample app
              value: "Hello Knative Serving is up and running with Kourier!!"
EOF

kubectl apply --filename tests/service.yaml  # access via <http://helloworld-go.default.192.168.1.36.sslip.io:31080>, port is from Kourier HTTP NodePort

# validate
kubectl get ksvc
```

Enable persistent volume claim

```bash
kubectl patch --namespace knative-serving configmap/config-features \
 --type merge \
 --patch '{"data":{"kubernetes.podspec-persistent-volume-claim": "enabled", "kubernetes.podspec-persistent-volume-write": "enabled"}}'
```

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->
