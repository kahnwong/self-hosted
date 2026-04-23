#!/bin/bash

kubectl create namespace vms
kubectl apply -f debian-vm.yaml
virtctl stop debian-vm
virtctl start debian-vm
