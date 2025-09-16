terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2025.8.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}
