# to test locally, run
# helm template ntfy  ../../charts/base/chart --values helm/deployments/default/ntfy.yaml

locals {
  deployments_default = toset([
    "actual",
    "dashy",
    "excalidraw",
    "gatus",
    "kanboard",
    "linkding",
    "memos",
    "minio",
    "monkeytype",
    "ntfy",
    "picoshare",
    "rustpad",
    "shouldideploytoday",
    "sshx",
  ])

  deployments_fringe_division = toset([
    "audiobookshelf",
    "jellyfin",
    "navidrome",
    "podgrab",
    "foo",
  ])

  deployments_forgejo = toset([
    "forgejo",
    "forgejo-postgres"
  ])

  deployments_immich = toset([
    "immich",
    "immich-machine-learning",
    "immich-postgres",
    "immich-valkey",
  ])

  deployments_livegrep = toset([
    "livegrep-backend",
    "livegrep-frontend"
  ])

  deployments_miniflux = toset([
    "miniflux",
    "miniflux-postgres"
  ])

  deployments_supersecretmessage = toset([
    "supersecretmessage",
    "supersecretmessage-vault",
  ])

  deployments_wallabag = toset([
    "wallabag",
    "wallabag-postgres",
    "wallabag-redis",
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
    file("./helm/deployments/default/${each.key}.yaml")
  ]
}

resource "helm_release" "ns_default_fringe_division" {
  for_each   = local.deployments_fringe_division
  name       = each.key
  namespace  = "default"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.2.0"
  chart      = "base"

  values = [
    file("./helm/deployments/default/${each.key}.yaml"),
    file("./resources/valuesTaintNodeSelector.yaml"),
  ]
}

resource "helm_release" "ns_forgejo" {
  for_each   = local.deployments_forgejo
  name       = each.key
  namespace  = "forgejo"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.2.0"
  chart      = "base"

  values = [
    file("./helm/deployments/forgejo/${each.key}.yaml")
  ]
}

# resource "helm_release" "harbor" {
#   name       = "harbor"
#   namespace  = "harbor"
#   repository = "oci://registry-1.docker.io/bitnamicharts"
#   version    = "21.1.5"
#   chart      = "harbor"
#
#   values = [
#     file("./helm/deployments/harbor/harbor.yaml"),
#   ]
#
#   set {
#     name  = "adminPassword"
#     value = var.registry_password
#   }
# }

resource "helm_release" "immich" {
  for_each   = local.deployments_immich
  name       = each.key
  namespace  = "immich"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.2.0"
  chart      = "base"

  values = [
    file("./helm/deployments/immich/${each.value}.yaml"),
    file("./resources/valuesTaintNodeSelector.yaml"),
  ]
}


resource "helm_release" "ns_livegrep" {
  for_each   = local.deployments_livegrep
  name       = each.key
  namespace  = "livegrep"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.2.0"
  chart      = "base"

  values = [
    file("./helm/deployments/livegrep/${each.key}.yaml")
  ]
}
data "sops_file" "livegrep" {
  source_file = "./helm/deployments/livegrep/livegrep-indexer.sops.yaml"
}
resource "helm_release" "livegrep_indexer" {
  name       = "livegrep-indexer"
  namespace  = "livegrep"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.1.0"
  chart      = "base-cronjob"

  values = [
    data.sops_file.livegrep.raw
  ]
}

resource "helm_release" "ns_miniflux" {
  for_each   = local.deployments_miniflux
  name       = each.key
  namespace  = "miniflux"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.2.0"
  chart      = "base"

  values = [
    file("./helm/deployments/miniflux/${each.key}.yaml")
  ]
}

resource "helm_release" "ns_supersecretmessage" {
  for_each   = local.deployments_supersecretmessage
  name       = each.key
  namespace  = "supersecretmessage"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.2.0"
  chart      = "base"

  values = [
    file("./helm/deployments/supersecretmessage/${each.key}.yaml")
  ]
}

resource "helm_release" "ns_wallabag" {
  for_each   = local.deployments_wallabag
  name       = each.key
  namespace  = "wallabag"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.2.0"
  chart      = "base"

  values = [
    file("./helm/deployments/wallabag/${each.key}.yaml")
  ]
}
