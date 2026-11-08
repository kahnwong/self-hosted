#!/bin/bash

#!/usr/bin/env bash
set -euo pipefail

if [ -z "${1:-}" ]; then
	echo "Error: Missing environment name." >&2
	echo "Usage: ./apply <name>" >&2
	exit 1
fi

REPO_NAME="$1"

sops -d runner.secret.sops.sh | sed "s/__REPO_NAME__/${REPO_NAME}/g" | sh
sops -d runner.values.sops.yaml | sed "s/__REPO_NAME__/${REPO_NAME}/g" |
	helm upgrade --install "arc-runner-${REPO_NAME}" \
		--namespace "arc-runners-${REPO_NAME}" \
		oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set \
		-f -
