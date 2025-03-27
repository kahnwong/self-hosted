terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.2.0"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "2.13.0"
    }
  }
}
