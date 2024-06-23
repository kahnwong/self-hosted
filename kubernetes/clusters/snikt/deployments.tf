# to test locally, run
# helm template ntfy  ../../charts/base/chart --values helm/deployments/default/ntfy.yaml

locals {
  deployments = tomap({
    default            = ["dashy", "excalidraw", "gatus", "linkding", "memos", "minio", "monkeytype", "ntfy", "picoshare", "rustpad", "shouldideploytoday", "sshx"]
    forgejo            = ["forgejo", "forgejo-postgres"]
    livegrep           = ["livegrep-backend", "livegrep-frontend"]
    miniflux           = ["miniflux", "miniflux-postgres"]
    supersecretmessage = ["supersecretmessage", "supersecretmessage-vault"]
    wallabag           = ["wallabag", "wallabag-postgres", "wallabag-redis"]
  })
}

locals {
  deployments_map_raw = flatten([
    for namespace, deployments in local.deployments : [
      for deployment in deployments : {
        deployment = deployment
        namespace  = namespace
      }
    ]
  ])
  deployments_map = { for index, v in local.deployments_map_raw : v.deployment => v.namespace }
}


locals {
  deployments_fringe_division = toset([
    "audiobookshelf",
    "jellyfin",
    "navidrome",
    "podgrab",
    "foo",
  ])

  deployments_immich = toset([
    "immich",
    "immich-machine-learning",
    "immich-postgres",
    "immich-valkey",
  ])
}

resource "helm_release" "this" {
  for_each   = local.deployments_map
  name       = each.key
  namespace  = each.value
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.2.0"
  chart      = "base"

  values = [
    file("./helm/deployments/${each.value}/${each.key}.yaml")
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
