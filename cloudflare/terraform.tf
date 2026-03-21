terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.4.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.18.0"
    }
  }
}
