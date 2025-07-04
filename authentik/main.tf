locals {
  application_oauth2 = tomap({
    gitea : ["https://git.karnwong.me/user/oauth2/authentik/callback"]
    harbor : ["https://harbor.karnwong.me/c/oidc/callback"]
    # hoarder : ["https://hoarder.karnwong.me/api/auth/callback/custom"]
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
    warpgate : ["https://warpgate.karnwong.me/@warpgate/api/sso/return"]
    }
  )
  application_proxy = toset([
    "dagster.cbp",
    "evcc",
    "gatus",
    "grafana.teslamate",
    "homer",
    "k.console.notes",
    "linkding",
    "livegrep",
    "microbin",
    "mlflow",
    "notes",
    "pdf",
    "send",
    "t.console.notes",
    "teslamate",
    "todotxt",
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
