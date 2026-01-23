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
    # opengist : ["https://gist.karnwong.me/oauth/openid-connect/callback"]
    # openwebui : ["https://chat.karnwong.me/oauth/oidc/callback"],
    paperless : ["https://paperless.karnwong.me/accounts/oidc/authentik/login/callback/"] # needs trailing slash
    # proxmox : ["https://proxmox.karnwong.me"]
    wakapi : ["https://wakapi.karnwong.me/oidc/authentik/callback"]
    warpgate : ["https://warpgate.karnwong.me/@warpgate/api/sso/return"]
    }
  )
  application_proxy_admin_only = toset([
    "livegrep",
    "np",
    "todotxt",
  ])
  application_proxy = toset([
    "homer",
    "k.console.notes",
    "linkding",
    "mlflow",
    "notes",
    "pdf",
    "t.console.notes",
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
  for_each = setunion(local.application_proxy_admin_only, local.application_proxy)

  source                = "./modules/authentik-application-proxy"
  authorization_flow_id = data.authentik_flow.default-authorization-flow.id
  invalidation_flow_id  = data.authentik_flow.default-invalidation-flow.id
  application_name      = each.key
}


data "authentik_group" "admins" {
  name = "authentik Admins"
}
resource "authentik_policy_binding" "app_access" { # deny non-admin users
  for_each = local.application_proxy_admin_only
  target   = module.application_proxy[each.key].application_uuid
  group    = data.authentik_group.admins.id
  order    = 0
}
