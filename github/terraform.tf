terraform {
  required_version = ">= 1.2.7"

  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.3.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.7.5"
    }
  }
}
