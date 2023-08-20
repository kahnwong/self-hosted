terraform {
  cloud {
    organization = "fringe-division"
    hostname     = "app.terraform.io"

    workspaces {
      tags = ["cloudflare"]
    }
  }
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "0.7.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.34.0"
    }
  }
}
