#!/bin/bash

kubectl apply -f ubuntu-vm.yaml
virtctl stop ubuntu-vm
virtctl start ubuntu-vm
