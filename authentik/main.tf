locals {
  application_oauth2 = tomap({
    gitea : ["https://git.karnwong.me/user/oauth2/authentik/callback"]
    harbor : ["https://harbor.karnwong.me/c/oidc/callback"]
    immich : [
      "app.immich:///oauth-callback",
      "https://immich.karnwong.me/auth/login",
      "https://immich.karnwong.me/user-settings",
    ]
    memos : ["https://memos.karnwong.me/auth/callback"]
    miniflux : ["https://miniflux.karnwong.me/oauth2/oidc/callback"]
    minio : ["https://console.minio.karnwong.me/oauth_callback"]
    opengist : ["https://gist.karnwong.me/oauth/openid-connect/callback"]
    proxmox : ["https://proxmox.karnwong.me"]
    }
  )
  application_proxy = toset([
    "dashy",
    "gatus",
    "linkding",
    "livegrep",
    "podgrab"
  ])
}

data "authentik_flow" "default-authorization-flow" {
  slug = "default-provider-authorization-implicit-consent"
}

module "application_oauth2" {
  for_each = local.application_oauth2

  source            = "./modules/authentik-application-oauth2"
  authentik_flow_id = data.authentik_flow.default-authorization-flow.id
  application_name  = each.key
  redirect_uris     = each.value
}

module "application_proxy" {
  for_each = local.application_proxy

  source            = "./modules/authentik-application-proxy"
  authentik_flow_id = data.authentik_flow.default-authorization-flow.id
  application_name  = each.key
}

# ----- mlflow ----- #
resource "authentik_provider_proxy" "mlflow" {
  name               = "Provider for mlflow"
  external_host      = "https://console.mlflow.karnwong.me"
  mode               = "forward_single"
  authorization_flow = data.authentik_flow.default-authorization-flow.id
}

resource "authentik_application" "mlflow" {
  name              = "mlflow"
  slug              = "mlflow"
  protocol_provider = authentik_provider_proxy.mlflow.id
}
