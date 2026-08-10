terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2026.5.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }
  }
}
