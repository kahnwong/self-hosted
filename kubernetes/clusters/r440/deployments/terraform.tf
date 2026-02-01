terraform {
  required_version = ">= 1.3.6"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "3.1.1"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
    # sops = {
    #   source  = "carlpett/sops"
    #   version = "1.3.0"
    # }
  }
}
