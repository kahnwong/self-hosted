terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.4.1"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "5.2.0"
    }
  }
}
