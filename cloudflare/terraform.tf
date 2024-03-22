terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.0.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.24.0"
    }
  }
}
