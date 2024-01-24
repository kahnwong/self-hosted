locals {
  deployments_default = toset([
    "audiobookshelf",
    "jellyfin",
    "linkding",
    "miniflux",
    "navidrome",
    "ntfy",
    "photoprism",
    "podgrab",
    "wallabag",
  ])
}

resource "helm_release" "ns_default" {
  for_each   = local.deployments_default
  name       = each.key
  namespace  = "default"
  repository = "oci://harbor.karnwong.me/charts"
  version    = "0.1.0"
  chart      = "base"

  values = [
    file("../../../kubernetes/nuc/default/${each.key}.yaml")
  ]
}

resource "helm_release" "harbor" {
  name       = "harbor"
  namespace  = "harbor"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  version    = "19.2.1"
  chart      = "harbor"

  values = [
    file("../../../kubernetes/nuc/harbor/values.yaml")
  ]

  set {
    name  = "adminPassword"
    value = var.registry_password
  }
}
