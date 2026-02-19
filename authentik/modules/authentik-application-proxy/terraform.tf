terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2025.12.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.0"
    }
  }
}
