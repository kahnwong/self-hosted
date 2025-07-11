terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.2.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.6.0"
    }
  }
}
