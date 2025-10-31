terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.3.0"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "4.0.0"
    }
  }
}
