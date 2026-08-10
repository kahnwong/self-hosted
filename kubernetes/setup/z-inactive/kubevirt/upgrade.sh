#!/bin/bash

# <https://kubevirt.io/user-guide/cluster_admin/updating_and_deletion/>

## kubevirt
# shellcheck disable=SC2155
export VERSION=$(curl -s https://storage.googleapis.com/kubevirt-prow/release/kubevirt/kubevirt/stable.txt)
echo "$VERSION"

export VERSION="v1.8.1" # make it explicit
kubectl apply -f "https://github.com/kubevirt/kubevirt/releases/download/${VERSION}/kubevirt-operator.yaml"

## cdi
# shellcheck disable=SC1083
export TAG=$(curl -s -w %{redirect_url} https://github.com/kubevirt/containerized-data-importer/releases/latest)
# shellcheck disable=SC2116
export VERSION=$(echo "${TAG##*/}")
export VERSION="v1.65.0" # make it explicit
# shellcheck disable=SC2086
kubectl apply -f https://github.com/kubevirt/containerized-data-importer/releases/download/$VERSION/cdi-operator.yaml
kubectl apply -f "https://github.com/kubevirt/containerized-data-importer/releases/download/${VERSION}/cdi-cr.yaml"
