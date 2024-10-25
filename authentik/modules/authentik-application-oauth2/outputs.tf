output "provider_oauth2_id" {
  value = authentik_provider_oauth2.this.id
}

output "oauth_client_id" {
  value     = authentik_provider_oauth2.this.client_id
  sensitive = true
}
output "oauth_client_secret" {
  value     = authentik_provider_oauth2.this.client_secret
  sensitive = true
}
