terraform {
  required_version = ">= 1.2.7"

  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.2.1"
    }
    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }
  }
}
