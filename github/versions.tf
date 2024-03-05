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
      version = "1.0.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.0.1"
    }
  }
}
