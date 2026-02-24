#!/bin/bash

kubectl create namespace vms
kubectl apply -f ubuntu-vm.yaml
virtctl stop ubuntu-vm
virtctl start ubuntu-vm
