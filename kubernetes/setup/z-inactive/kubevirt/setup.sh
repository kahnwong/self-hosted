#!/bin/bash

# shellcheck disable=SC2155
#export VERSION=$(curl -s https://storage.googleapis.com/kubevirt-prow/release/kubevirt/kubevirt/stable.txt)
export VERSION="v1.8.1"
echo "$VERSION"

# install components
kubectl create -f "https://github.com/kubevirt/kubevirt/releases/download/${VERSION}/kubevirt-operator.yaml"
kubectl create -f "https://github.com/kubevirt/kubevirt/releases/download/${VERSION}/kubevirt-cr.yaml"

# install cdi
# shellcheck disable=SC1083
#export TAG=$(curl -s -w %{redirect_url} https://github.com/kubevirt/containerized-data-importer/releases/latest)
# shellcheck disable=SC2116
#export VERSION=$(echo "${TAG##*/}")
export VERSION="v1.65.0"

# shellcheck disable=SC2086
kubectl create -f https://github.com/kubevirt/containerized-data-importer/releases/download/$VERSION/cdi-operator.yaml
kubectl create -f https://github.com/kubevirt/containerized-data-importer/releases/download/"$VERSION"/cdi-cr.yaml

# verify installation
kubectl get kubevirt.kubevirt.io/kubevirt -n kubevirt -o=jsonpath="{.status.phase}"
kubectl get all -n kubevirt

# enable features
kubectl apply -f enable-feature-gate.yaml

# patch storageprofile
kubectl patch storageprofile local-path --type=merge -p '{
  "spec": {
    "claimPropertySets": [
      {
        "accessModes": ["ReadWriteOnce"],
        "volumeMode": "Filesystem"
      }
    ]
  }
}'
