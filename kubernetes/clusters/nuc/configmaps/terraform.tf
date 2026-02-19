terraform {
  required_version = ">= 1.3.6"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.3.0"
    }
  }
}
