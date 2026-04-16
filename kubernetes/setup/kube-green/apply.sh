#!/bin/bash

kubectl apply -f selective-sleep.yaml --namespace infrastructure
kubectl apply -f selective-sleep.yaml --namespace tools
