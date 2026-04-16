#!/bin/bash

git clone https://github.com/llm-d/llm-d.git
cd llm-d || exit 1
git checkout 84ba2f7
cd guides/inference-scheduling || exit 1

# to be removed
helmfile destroy -e agentgateway -n llm-d

# patch model
yq e -i '(.modelArtifacts.uri) = "hf://google/gemma-3-1b-it"' ms-inference-scheduling/values_cpu.yaml
yq e -i '(.modelArtifacts.name) = "google/gemma-3-1b-it"' ms-inference-scheduling/values_cpu.yaml
yq e -i '(.modelArtifacts.size) = "20Gi"' ms-inference-scheduling/values_cpu.yaml
yq e -i '(.modelArtifacts.labels."llm-d.ai/model") = "gemma-3-1b-it"' ms-inference-scheduling/values_cpu.yaml
yq e -i '(.decode.replicas) = 1' ms-inference-scheduling/values_cpu.yaml
yq e -i '(.decode.containers[0].resources.limits.cpu) = 8' ms-inference-scheduling/values_cpu.yaml
yq e -i '(.decode.containers[0].resources.limits.memory) = "16Gi"' ms-inference-scheduling/values_cpu.yaml
yq e -i '(.decode.containers[0].resources.requests.cpu) = 8' ms-inference-scheduling/values_cpu.yaml
yq e -i '(.decode.containers[0].resources.requests.memory) = "16Gi"' ms-inference-scheduling/values_cpu.yaml
yq e -i '(.decode.containers[0].env[1].value) = "32"' ms-inference-scheduling/values_cpu.yaml

# agentgateway by default use values.yaml, so we need to patch it with values_cpu.yaml
cp ms-inference-scheduling/values_cpu.yaml ms-inference-scheduling/values.yaml

# apply
helmfile apply -e agentgateway -n llm-d
kubectl apply -f httproute.yaml -n llm-d

# # destroy
# helmfile destroy -e agentgateway -n llm-d
