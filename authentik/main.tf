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
    # minio : ["https://console.minio.karnwong.me/oauth_callback"]
    # opengist : ["https://gist.karnwong.me/oauth/openid-connect/callback"]
    openwebui : ["https://chat.karnwong.me/oauth/oidc/callback"],
    paperless : ["https://paperless.karnwong.me/accounts/oidc/authentik/login/callback/"] # needs trailing slash
    # proxmox : ["https://proxmox.karnwong.me"]
    warpgate : ["https://warpgate.karnwong.me/@warpgate/api/sso/return"]
    }
  )
  application_proxy = toset([
    "homer",
    "k.console.notes",
    "linkding",
    "livegrep",
    "mlflow",
    "notes",
    "np",
    "pdf",
    "t.console.notes",
    "todotxt",
  ])
}

data "authentik_flow" "default-authorization-flow" {
  slug = "default-provider-authorization-implicit-consent"
}
data "authentik_flow" "default-invalidation-flow" {
  slug = "default-provider-invalidation-flow"
}

module "application_oauth2" {
  for_each = local.application_oauth2

  source                = "./modules/authentik-application-oauth2"
  authorization_flow_id = data.authentik_flow.default-authorization-flow.id
  invalidation_flow_id  = data.authentik_flow.default-invalidation-flow.id
  application_name      = each.key
  redirect_uris         = each.value
}

module "application_proxy" {
  for_each = local.application_proxy

  source                = "./modules/authentik-application-proxy"
  authorization_flow_id = data.authentik_flow.default-authorization-flow.id
  invalidation_flow_id  = data.authentik_flow.default-invalidation-flow.id
  application_name      = each.key
}
