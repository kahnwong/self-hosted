#!/bin/bash

namespace="coroot"
kubectl port-forward -n $namespace service/coroot 8080:8080
