# snikt

## Run this by hand

```bash
kubectl taint nodes fringe-division storage-required=true:NoSchedule
```

### Knative

- <https://knative.dev/docs/install/yaml-install/serving/install-serving-with-yaml/#install-the-knative-serving-component>
- <https://knative.dev/blog/articles/set-up-a-local-knative-environment-with-kind/>

```bash
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.16.0/serving-crds.yaml
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.16.0/serving-core.yaml
kubectl apply -f https://github.com/knative/net-kourier/releases/download/knative-v1.16.0/kourier.yaml

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

kubectl apply --filename service.yaml  # access via <http://helloworld-go.default.192.168.1.36.sslip.io:31080>, port is from Kourier HTTP NodePort

# validate
kubectl get ksvc
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.6 |
| helm | 2.16.1 |
| kubectl | ~> 2.0 |
| kubernetes | 2.33.0 |
| sops | 1.1.1 |

## Providers

| Name | Version |
|------|---------|
| helm | 2.16.1 |
| kubernetes | 2.33.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.authentik](https://registry.terraform.io/providers/hashicorp/helm/2.16.1/docs/resources/release) | resource |
| [helm_release.fringe_division](https://registry.terraform.io/providers/hashicorp/helm/2.16.1/docs/resources/release) | resource |
| [helm_release.harbor](https://registry.terraform.io/providers/hashicorp/helm/2.16.1/docs/resources/release) | resource |
| [helm_release.knative](https://registry.terraform.io/providers/hashicorp/helm/2.16.1/docs/resources/release) | resource |
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/2.16.1/docs/resources/release) | resource |
| [kubernetes_cluster_role.deployment_restart](https://registry.terraform.io/providers/hashicorp/kubernetes/2.33.0/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.pod_exec](https://registry.terraform.io/providers/hashicorp/kubernetes/2.33.0/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.deployment_restart](https://registry.terraform.io/providers/hashicorp/kubernetes/2.33.0/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.pod_exec](https://registry.terraform.io/providers/hashicorp/kubernetes/2.33.0/docs/resources/cluster_role_binding) | resource |
| [kubernetes_manifest.notes_sync](https://registry.terraform.io/providers/hashicorp/kubernetes/2.33.0/docs/resources/manifest) | resource |
| [kubernetes_manifest.qa_discord_bot](https://registry.terraform.io/providers/hashicorp/kubernetes/2.33.0/docs/resources/manifest) | resource |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/2.33.0/docs/resources/namespace) | resource |
| [kubernetes_secret.deployment_restart](https://registry.terraform.io/providers/hashicorp/kubernetes/2.33.0/docs/resources/secret) | resource |
| [kubernetes_secret.pod_exec](https://registry.terraform.io/providers/hashicorp/kubernetes/2.33.0/docs/resources/secret) | resource |
| [kubernetes_service_account.deployment_restart](https://registry.terraform.io/providers/hashicorp/kubernetes/2.33.0/docs/resources/service_account) | resource |
| [kubernetes_service_account.pod_exec](https://registry.terraform.io/providers/hashicorp/kubernetes/2.33.0/docs/resources/service_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_certificate | n/a | `string` | n/a | yes |
| client\_key | n/a | `string` | n/a | yes |
| cluster\_ca\_certificate | n/a | `string` | n/a | yes |
| host | n/a | `string` | n/a | yes |
| registry\_password | n/a | `string` | n/a | yes |
| registry\_server | n/a | `string` | n/a | yes |
| registry\_username | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
