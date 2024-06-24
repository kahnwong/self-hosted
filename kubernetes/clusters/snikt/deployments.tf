# to test locally, run
# helm template ntfy  ../../charts/base/chart --values helm/deployments/default/ntfy.yaml

locals {
  deployments = tomap({
    default            = ["dashy", "excalidraw", "linkding", "memos", "monkeytype", "rustpad", "shouldideploytoday", "sshx"]
    miniflux           = ["miniflux", "miniflux-postgres"]
    infrastructure     = ["gatus", "minio", "ntfy", "forgejo", "forgejo-postgres"]
    supersecretmessage = ["supersecretmessage", "supersecretmessage-vault"]
    tools              = ["livegrep-backend", "livegrep-frontend", "picoshare"]
    wallabag           = ["wallabag", "wallabag-postgres", "wallabag-redis"]
  })
  deployments_fringe_division = tomap({
    default = ["audiobookshelf", "jellyfin", "navidrome", "podgrab", "foo"]
    immich  = ["immich", "immich-machine-learning", "immich-postgres", "immich-valkey"]
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

  deployments_fringe_division_map_raw = flatten([
    for namespace, deployments in local.deployments_fringe_division : [
      for deployment in deployments : {
        namespace  = namespace
        deployment = deployment
      }
    ]
  ])
  deployments_fringe_division_map = { for index, v in local.deployments_fringe_division_map_raw : v.deployment => v.namespace }
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

resource "helm_release" "fringe_division" {
  for_each   = local.deployments_fringe_division_map
  name       = each.key
  namespace  = each.value
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.2.0"
  chart      = "base"

  values = [
    file("./helm/deployments/${each.value}/${each.key}.yaml"),
    file("./resources/valuesTaintNodeSelector.yaml"),
  ]
}
