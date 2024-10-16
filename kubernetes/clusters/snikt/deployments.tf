# to test locally, run
# helm template ntfy  ../../charts/base/chart --values helm/deployments/default/ntfy.yaml

locals {
  deployments = tomap({
    bots    = ["qa-api", "qa-api-rs"]
    default = ["dashy", "linkding", "memos", "subsonic-widgets"]
    news = [
      "miniflux", "miniflux-postgres",
      "wallabag", "wallabag-postgres", "wallabag-redis",
      "thai-tech-cal",
    ]
    infrastructure = [
      "gitea", "gitea-postgres",
      "mlflow", "mlflow-postgres",
      "gatus", "minio", "ntfy",
    ]
    tools = [
      "livegrep-backend", "livegrep-frontend",
      "supersecretmessage", "supersecretmessage-vault",
      "excalidraw", "go-playground", "opengist", "picoshare", "rustpad", "sshx",
    ]
  })
  deployments_fringe_division = tomap({
    default = [
      "audiobookshelf", "podgrab",
      "navidrome",
      "jellyfin",
      "calibre-web",
      "foo", "baz"
    ]
    immich = ["immich", "immich-machine-learning", "immich-postgres", "immich-valkey"]
    plausible = [
      "plausible", "plausible-clickhouse", "plausible-postgres",
    ]
    tools = [
      "wakapi", "wakapi-postgres",
      #      "stirling-pdf",
    ]
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

resource "kubernetes_manifest" "qa_discord_bot" {
  manifest = yamldecode(file("./helm/deployments/bots/qa-discord-bot.yaml"))
}

resource "helm_release" "harbor" {
  name       = "harbor"
  namespace  = "harbor"
  repository = "https://helm.goharbor.io"
  version    = "1.15.1"
  chart      = "harbor"

  values = [
    file("./helm/deployments/harbor/values.yaml")
  ]

  set {
    name  = "harborAdminPassword"
    value = var.registry_password
  }
}
