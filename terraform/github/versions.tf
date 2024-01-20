terraform {
  required_version = ">= 1.2.7"

  cloud {
    organization = "fringe-division"
    hostname     = "app.terraform.io"

    workspaces {
      tags = ["github"]
    }
  }

  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }
    github = {
      source  = "integrations/github"
      version = "5.45.0"
    }
  }
}
