terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.0.0"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "1.12.0"
    }
  }
}
