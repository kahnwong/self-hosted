locals {
  application_oauth2 = tomap({
    }
  )
  application_proxy_admin_only = toset([
  ])
  application_proxy = toset([
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
