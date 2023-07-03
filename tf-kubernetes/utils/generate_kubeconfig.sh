#!/bin/bash

server=https://localhost:6443
name=sa-foo

ca=$(kubectl get secret/$name-token -o jsonpath='{.data.ca\.crt}')
token=$(kubectl get secret/$name-token -o jsonpath='{.data.token}' | base64 --decode)
namespace=$(kubectl get secret/$name-token -o jsonpath='{.data.namespace}' | base64 --decode)

echo "
apiVersion: v1
kind: Config
clusters:
- name: default-cluster
  cluster:
    certificate-authority-data: ${ca}
    server: ${server}
contexts:
- name: default-context
  context:
    cluster: default-cluster
    namespace: default
    user: $name
current-context: default-context
users:
- name: $name
  user:
    token: ${token}
" > $name.kubeconfig
