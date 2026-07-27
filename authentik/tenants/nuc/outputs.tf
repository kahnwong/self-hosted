output "oauth2_credentials" {
  value     = module.application_oauth2
  sensitive = true
}

output "oauth_credentials_beszel" {
  value = {
    "client_id" : authentik_provider_oauth2.beszel.client_id,
    "client_secret" : authentik_provider_oauth2.beszel.client_secret
  }

  sensitive = true
}

