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
    bots      = ["qa-api"]
    default = [
      "subsonic-widgets",
      "foo", "baz"
    ]
    immich = ["immich", "immich-machine-learning", "immich-postgres", "immich-valkey"]
    infrastructure = [
      "gatus",
      "forgejo", "forgejo-postgres",
      "minio",
      "mlflow", "mlflow-postgres",
      "ntfy",
    ]
    media = [
      "navidrome",
      "podgrab",
    ]
    news = [
      "miniflux", "miniflux-postgres",
      "wallabag", "wallabag-postgres", "wallabag-redis",
    ]
    notes = [
      "notes",
      "notes-console-k",
      "notes-console-t",
    ]
    plausible = [
      "plausible", "plausible-clickhouse", "plausible-postgres",
    ]
    tools = [
      "livegrep-backend", "livegrep-frontend",
      "memos",
      "sshx",
      "supersecretmessage", "supersecretmessage-vault",
      "wakapi", "wakapi-postgres",
      #      "stirling-pdf",
    ]
  })
  deployments_knative = tomap({
    media = [
      "audiobookshelf",
      "calibre-web",
      "jellyfin",
    ]
    news = [
      "thai-tech-cal",
    ]
    playground = [
      "go-playground",
    ]
    tools = [
      "dashy",
      "excalidraw",
      "linkding",
      "opengist",
      "picoshare",
      "rustpad",
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

  deployments_knative_map_raw = flatten([
    for namespace, deployments in local.deployments_knative : [
      for deployment in deployments : {
        namespace  = namespace
        deployment = deployment
      }
    ]
  ])
  deployments_knative_map = { for index, v in local.deployments_knative_map_raw : v.deployment => v.namespace }
}


resource "helm_release" "this" {
  for_each   = local.deployments_map
  name       = each.key
  namespace  = each.value
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.2.0"
  chart      = "base"

  values = [
    file("./deployments/${each.value}/${each.key}.yaml")
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
    file("./deployments/${each.value}/${each.key}.yaml"),
    # file("./resources/valuesTaintNodeSelector.yaml"),
  ]
}

resource "helm_release" "knative" {
  for_each   = local.deployments_knative_map
  name       = each.key
  namespace  = each.value
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.2.0"
  chart      = "base-knative"

  values = [
    file("./deployments/${each.value}/${each.key}.yaml"),
    # file("./resources/valuesTaintNodeSelector.yaml"),
  ]
}

# ------ qa-discord-bot ------ #
resource "kubernetes_manifest" "qa_discord_bot" {
  manifest = yamldecode(file("./deployments/bots/qa-discord-bot.yaml"))
}

# ------ notes-sync ------ #
resource "kubernetes_manifest" "notes_sync" {
  manifest = yamldecode(file("./deployments/notes/notes-sync.yaml"))
}

# ------ harbor ------ #
resource "helm_release" "harbor" {
  name       = "harbor"
  namespace  = "harbor"
  repository = "https://helm.goharbor.io"
  version    = "1.15.1"
  chart      = "harbor"

  values = [
    file("./deployments/harbor/values.yaml")
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
  version    = "2024.10.2"
  chart      = "authentik"

  values = [
    file("./deployments/authentik/values.yaml"),
  ]
}

# # ------ woodpecker ------ #
# resource "helm_release" "woodpecker" {
#   # oauth redirect url: `https://ci.karnwong.me/authorize`
#   # add users via <https://woodpecker-ci.org/docs/administration/server-config#user-registration>
#   name       = "woodpecker"
#   namespace  = "woodpecker"
#   repository = "https://woodpecker-ci.org"
#   version    = "1.6.0"
#   chart      = "woodpecker"
#
#   timeout = 90
#
#   values = [
#     file("./deployments/woodpecker/woodpecker.yaml"),
#   ]
# }
