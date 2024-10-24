data "authentik_flow" "default-authorization-flow" {
  slug = "default-provider-authorization-implicit-consent"
}

resource "authentik_provider_proxy" "podgrab" {
  name               = "podgrab"
  internal_host      = "https://podgrab.karnwong.me"
  external_host      = "https://podgrab.karnwong.me"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
}

resource "authentik_application" "name" {
  name              = "podgrab"
  slug              = "podgrab"
  protocol_provider = authentik_provider_proxy.podgrab.id
}
