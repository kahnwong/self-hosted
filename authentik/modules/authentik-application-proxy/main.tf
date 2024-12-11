resource "authentik_provider_proxy" "this" {
  name               = "Provider for ${var.application_name}"
  external_host      = "https://${var.application_name}.karnwong.me"
  mode               = "forward_single"
  authorization_flow = var.authorization_flow_id
  invalidation_flow  = var.invalidation_flow_id
}

resource "authentik_application" "this" {
  name              = var.application_name
  slug              = replace(var.application_name, ".", "-")
  protocol_provider = authentik_provider_proxy.this.id
}
