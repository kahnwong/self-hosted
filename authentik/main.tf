locals {
  applications = toset([
    "dashy",
    "livegrep",
    "podgrab"
  ])
}

module "application" {
  for_each = local.applications

  source           = "./modules/authentik-application"
  application_name = each.key
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
  protocol_providers = [for app in module.application : app.proxy_id]
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
