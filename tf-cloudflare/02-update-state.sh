#!/bin/bash

sops -e terraform.tfstate > terraform.sops.tfstate
git add terraform.sops.tfstate
