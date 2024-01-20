terraform {
  required_version = ">= 1.3.6"

  cloud {
    organization = "fringe-division"
    hostname     = "app.terraform.io"

    workspaces {
      tags = ["kubernetes-snikt"]
    }
  }

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.22.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "1.0.0"
    }
  }
}
