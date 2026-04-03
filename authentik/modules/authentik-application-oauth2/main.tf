resource "random_string" "random" {
  length  = 40
  special = false
}

resource "authentik_provider_oauth2" "this" {
  name      = "Provider for ${var.application_name}"
  client_id = random_string.random.result

  authorization_flow = var.authorization_flow_id
  invalidation_flow  = var.invalidation_flow_id

  allowed_redirect_uris = [
    for uri in var.redirect_uris : {
      matching_mode = "strict"
      url           = uri
    }
  ]

  property_mappings = var.property_mappings
  signing_key       = var.signing_key
}

resource "authentik_application" "this" {
  name              = var.application_name
  slug              = var.application_name
  protocol_provider = authentik_provider_oauth2.this.id
}
