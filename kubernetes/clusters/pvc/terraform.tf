terraform {
  required_version = ">= 1.3.6"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.38.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.2.1"
    }
  }
}
