terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.1.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.52.0"
    }
  }
}
