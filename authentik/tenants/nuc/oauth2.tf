resource "authentik_property_mapping_provider_scope" "email_verified" {
  name        = "OAuth Mapping: OpenID 'email' (email_verified: True)"
  scope_name  = "email"
  description = "Custom email scope returning email_verified as True"
  expression  = <<EOF
return {
    "email": request.user.email,
    "email_verified": True,
}
EOF
}

data "authentik_property_mapping_provider_scope" "scopes" {
  for_each = toset(["openid", "profile"])
  managed  = "goauthentik.io/providers/oauth2/scope-${each.value}"
}
