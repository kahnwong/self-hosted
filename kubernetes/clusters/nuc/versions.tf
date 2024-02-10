terraform {
  required_version = ">= 1.3.6"

  cloud {
    organization = "fringe-division"
    hostname     = "app.terraform.io"

    workspaces {
      tags = ["kubernetes"]
    }
  }

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.25.2"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.0.0"
    }
  }
}
