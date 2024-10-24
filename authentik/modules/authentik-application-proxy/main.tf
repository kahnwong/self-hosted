data "authentik_flow" "default-authorization-flow" {
  slug = "default-provider-authorization-implicit-consent"
}

resource "authentik_provider_proxy" "this" {
  name               = "Provider for ${var.application_name}"
  external_host      = "https://${var.application_name}.karnwong.me"
  mode               = "forward_single"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
}

resource "authentik_application" "this" {
  name              = var.application_name
  slug              = var.application_name
  protocol_provider = authentik_provider_proxy.this.id
}
