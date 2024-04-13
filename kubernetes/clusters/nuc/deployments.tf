locals {
  deployments_default = toset([
    #     "audiobookshelf",
    "jellyfin",
    "navidrome",
    "podgrab",
  ])
}

resource "helm_release" "ns_default" {
  for_each   = local.deployments_default
  name       = each.key
  namespace  = "default"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.2.0"
  chart      = "base"

  values = [
    file("./deployments/default/${each.key}.yaml")
  ]
}

resource "helm_release" "harbor" {
  name       = "harbor"
  namespace  = "harbor"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  version    = "21.1.1"
  chart      = "harbor"

  values = [
    file("./deployments/harbor/values.yaml")
  ]

  set {
    name  = "adminPassword"
    value = var.registry_password
  }
}

resource "helm_release" "immich" {
  name       = "immich"
  namespace  = "immich"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.1.0"
  chart      = "base"

  values = [
    file("./deployments/immich/immich.yaml")
  ]
}
