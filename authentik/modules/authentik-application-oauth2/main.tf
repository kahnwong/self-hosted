resource "random_string" "random" {
  length  = 40
  special = false
}

data "authentik_flow" "default-authorization-flow" {
  slug = "default-provider-authorization-implicit-consent"
}

## for obtaining `property_mappings`
# import {
#   id = "19"
#   to = authentik_provider_oauth2.this
# }
resource "authentik_provider_oauth2" "this" {
  name               = "Provider for ${var.application_name}"
  client_id          = random_string.random.result
  authorization_flow = data.authentik_flow.default-authorization-flow.id
  redirect_uris      = [var.redirect_uri]
  property_mappings = [
    "3ccc549e-2d36-4c94-a69f-1d56ba28af89",
    "7098b9ee-bd9f-40fe-852b-c6fb9ec262c3",
    "bfa6ff96-43b1-4e8b-b3c1-4cb8440bde6a",
    "e3eea4e2-55cf-4a34-9179-3760c3d71448",
  ]
  signing_key = "fee092b8-838a-4515-a4bb-54148dcb0dcf"
}

resource "authentik_application" "memos" {
  name              = var.application_name
  slug              = var.application_name
  protocol_provider = authentik_provider_oauth2.this.id
}
