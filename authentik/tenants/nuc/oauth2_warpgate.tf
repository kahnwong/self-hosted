resource "random_string" "random_warpgate" {
  length  = 40
  special = false
}

resource "authentik_provider_oauth2" "warpgate" {
  name      = "Provider for warpgate"
  client_id = random_string.random_warpgate.result

  authorization_flow = data.authentik_flow.default-authorization-flow.id
  invalidation_flow  = data.authentik_flow.default-invalidation-flow.id

  allowed_redirect_uris = [
    {
      matching_mode     = "strict"
      redirect_uri_type = "authorization"
      url               = "https://console.warpgate.karnwong.me/@warpgate/api/sso/return"
    }
  ]

  property_mappings = concat(
    [for s in data.authentik_property_mapping_provider_scope.scopes : s.id],
    [authentik_property_mapping_provider_scope.email_verified.id]
  )

  signing_key = var.signing_key

  grant_types = ["authorization_code", "refresh_token"]
}

resource "authentik_application" "warpgate" {
  name              = "warpgate"
  slug              = "warpgate"
  protocol_provider = authentik_provider_oauth2.warpgate.id
}
