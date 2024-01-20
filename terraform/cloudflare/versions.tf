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
      version = "1.0.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.34.0"
    }
  }
}
