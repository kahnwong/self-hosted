#!/bin/bash

export NAMESPACE=llm-d
kubectl create namespace ${NAMESPACE}

export HF_TOKEN="from Huggingface" # set value and clear it - secrets shouldn't be stored in plaintext
export HF_TOKEN_NAME=${HF_TOKEN_NAME:-llm-d-hf-token}
kubectl create secret generic "${HF_TOKEN_NAME}" \
	--from-literal="HF_TOKEN=${HF_TOKEN}" \
	--namespace "${NAMESPACE}" \
	--dry-run=client -o yaml | kubectl apply -f -

curl https://raw.githubusercontent.com/llm-d/llm-d/refs/heads/main/docs/monitoring/scripts/install-prometheus-grafana.sh | bash
curl https://raw.githubusercontent.com/llm-d/llm-d/refs/heads/main/guides/prereq/gateway-provider/install-gateway-provider-dependencies.sh | bash
helmfile apply -f https://raw.githubusercontent.com/llm-d/llm-d/refs/heads/main/guides/prereq/gateway-provider/agentgateway.helmfile.yaml

# verify installation
kubectl api-resources --api-group=inference.networking.k8s.io
