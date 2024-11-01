# to test locally, run
# helm template ntfy  ../../charts/base/chart --values helm/deployments/default/ntfy.yaml

locals {
  deployments = tomap({
    default = []
    news = [
    ]
    infrastructure = [
    ]
    tools = [
    ]
  })
  deployments_fringe_division = tomap({
    authentik = ["authentik-postgres", "authentik-valkey"]
    bots      = ["qa-api-rs"]
    default = [
      "audiobookshelf",
      "calibre-web",
      "dashy",
      "jellyfin",
      "linkding",
      "memos",
      "navidrome",
      "podgrab",
      "subsonic-widgets",
      "foo", "baz"
    ]
    immich = ["immich", "immich-machine-learning", "immich-postgres", "immich-valkey"]
    infrastructure = [
      "gatus",
      "gitea", "gitea-postgres",
      "minio",
      "mlflow", "mlflow-postgres",
      "ntfy",
    ]
    news = [
      "miniflux", "miniflux-postgres",
      "thai-tech-cal",
      "wallabag", "wallabag-postgres", "wallabag-redis",
    ]
    plausible = [
      "plausible", "plausible-clickhouse", "plausible-postgres",
    ]
    tools = [
      "excalidraw",
      "go-playground",
      "livegrep-backend", "livegrep-frontend",
      "opengist",
      "picoshare",
      "rustpad",
      "sshx",
      "supersecretmessage", "supersecretmessage-vault",
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
    # file("./resources/valuesTaintNodeSelector.yaml"),
  ]
}

# ------ qa-discord-bot ------ #
resource "kubernetes_manifest" "qa_discord_bot" {
  manifest = yamldecode(file("./helm/deployments/bots/qa-discord-bot.yaml"))
}

# ------ harbor ------ #
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

# ------ authentik ------ #
resource "helm_release" "authentik" {
  name       = "authentik"
  namespace  = "authentik"
  repository = "https://charts.goauthentik.io"
  version    = "2024.10.0"
  chart      = "authentik"

  values = [
    file("./helm/deployments/authentik/values.yaml"),
  ]
}
