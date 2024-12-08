terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.1.1"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "1.14.1"
    }
  }
}
