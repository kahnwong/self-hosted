#!/bin/bash

sops -d terraform.sops.tfstate > terraform.tfstate
