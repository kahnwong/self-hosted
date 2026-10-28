#!/bin/bash

if [ -z "$1" ]; then
	echo "Error: No argument provided."
	echo "Usage: $0 <service>"
	exit 1
fi

tofu apply -target="module.base.helm_release.this[\"$1\"]"
