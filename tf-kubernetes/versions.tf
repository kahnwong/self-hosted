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
    flux = {
      source  = "fluxcd/flux"
      version = "1.0.0-rc.5"
    }
    github = {
      source  = "integrations/github"
      version = ">=5.18.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.21.1"
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }
  }
}
