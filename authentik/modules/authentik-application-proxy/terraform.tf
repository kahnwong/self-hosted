terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2024.10.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}
