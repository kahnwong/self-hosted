locals {
  application_oauth2 = tomap({
    harbor : ["https://harbor.karnwong.me/c/oidc/callback"]
    immich : [
      "app.immich:///oauth-callback",
      "https://immich.karnwong.me/auth/login",
      "https://immich.karnwong.me/user-settings",
    ]
    memos : ["https://memos.karnwong.me/auth/callback"]
    miniflux : ["https://miniflux.karnwong.me/oauth2/oidc/callback"]
    minio : ["https://console.minio.karnwong.me/oauth_callback"]
    }
  )
  application_proxy = toset([
    "dashy",
    "livegrep",
    "gatus",
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

## obtain from browser inspector
# import {
#   id = "xxxxx-xxxx-xxx-xxx-xxxx"
#   to = authentik_service_connection_kubernetes.local
# }
resource "authentik_service_connection_kubernetes" "local" {
  name  = "Local Kubernetes Cluster"
  local = true
}

## obtain from browser inspector
# import {
#   id = "xxxxx-xxxx-xxx-xxx-xxxx"
#   to = authentik_outpost.proxy_outpost
# }
resource "authentik_outpost" "proxy_outpost" {
  name               = "authentik Embedded Outpost"
  protocol_providers = [for app in module.application_proxy : app.provider_proxy_id]
  config = jsonencode({
    authentik_host                 = format(var.authentik_host)
    authentik_host_browser         = ""
    authentik_host_insecure        = false
    container_image                = null
    docker_labels                  = null
    docker_map_ports               = true
    docker_network                 = null
    kubernetes_disabled_components = []
    kubernetes_image_pull_secrets  = []
    kubernetes_ingress_annotations = {}
    kubernetes_ingress_class_name  = null
    kubernetes_ingress_secret_name = "authentik-outpost-tls"
    kubernetes_json_patches        = null
    kubernetes_namespace           = "authentik"
    kubernetes_replicas            = 1
    kubernetes_service_type        = "ClusterIP"
    log_level                      = "info"
    object_naming_template         = "ak-outpost-%(name)s"
    refresh_interval               = "minutes=5"
  })
  service_connection = authentik_service_connection_kubernetes.local.id
}
