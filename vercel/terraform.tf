terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.2.0"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "3.2.1"
    }
  }
}
