terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.2.1"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "3.17.0"
    }
  }
}
