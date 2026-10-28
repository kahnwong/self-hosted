resource "random_string" "random_beszel" {
  length  = 40
  special = false
}

resource "authentik_provider_oauth2" "beszel" {
  name      = "Provider for beszel"
  client_id = random_string.random_beszel.result

  authorization_flow = data.authentik_flow.default-authorization-flow.id
  invalidation_flow  = data.authentik_flow.default-invalidation-flow.id

  allowed_redirect_uris = [
    {
      matching_mode     = "strict"
      redirect_uri_type = "authorization"
      url               = "https://beszel.karnwong.me/api/oauth2-redirect"
    }
  ]

  property_mappings = concat(
    [for s in data.authentik_property_mapping_provider_scope.scopes : s.id],
    [authentik_property_mapping_provider_scope.email_verified.id]
  )

  signing_key = var.signing_key

  grant_types = ["authorization_code", "refresh_token"]
}

resource "authentik_application" "beszel" {
  name              = "beszel"
  slug              = "beszel"
  protocol_provider = authentik_provider_oauth2.beszel.id
}
