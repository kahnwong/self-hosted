terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2025.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }
}
