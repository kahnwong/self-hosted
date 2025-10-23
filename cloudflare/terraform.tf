terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.3.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.10.1"
    }
  }
}
