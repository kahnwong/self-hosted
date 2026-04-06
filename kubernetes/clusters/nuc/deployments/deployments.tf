# to test locally, run
# helm template ntfy  ../../charts/base/chart --values helm/deployments/default/ntfy.yaml

locals {
  deployments_base = tomap({
    analytics = []
    authentik = ["authentik-postgres", "authentik-valkey"]
    default   = []
    harbor    = ["harbor-postgres"]
    immich    = ["immich", "immich-machine-learning", "immich-postgres", "immich-valkey"]
    infrastructure = [
      "forgejo", "forgejo-postgres",
      "garage",
      "llm-honeypot",
      "mlflow", "mlflow-postgres",
      "ntfy",
    ]
    media = [
      "navidrome",
    ]
    news = [
      "miniflux", "miniflux-postgres",
      "wallabag", "wallabag-postgres", "wallabag-redis",
    ]
    notes = [
      "notes-personal",
    ]
    tools = [
      "cpubench",
      "evcc",
      "homer",
      "linkding",
      "livegrep-backend", "livegrep-frontend",
      "nocodb",
      "paperless-ngx", "paperless-ngx-valkey",
      "qrcode-api",
      "rallly", "rallly-postgres",
      "retrooo",
      "rss-bridge",
      "sshx",
      "subsonic-widgets",
      "supersecretmessage", "supersecretmessage-vault",
      "todotxt",
      "wakapi", "wakapi-postgres",
      "weather-api",
    ]
  })
  deployments_knative = tomap({
    media = [
      "jellyfin",
    ]
    news = [
      "thai-tech-cal",
    ]
    notes = [
      # "notes-console-k",
      # "notes-console-t",
    ]
    playground = [
      "go-playground",
    ]
    tools = [
      "rustpad",
      "stirling-pdf",
    ]
  })
}

module "base" {
  source = "../../../modules/deployments"

  deployments   = local.deployments_base
  chart_name    = "base"
  chart_version = "0.2.2"
  values_extras = []
}


module "knative" {
  source = "../../../modules/deployments"

  deployments   = local.deployments_knative
  chart_name    = "base-knative"
  chart_version = "0.2.0"
  values_extras = [
    # "./resources/valuesTaintNodeSelector.yaml",
  ]
}

# ------ notes-sync ------ #
resource "kubernetes_manifest" "notes_personal" {
  manifest = yamldecode(file("../../../specs/deployments/notes/notes-personal-sync.yaml"))
}

# ------ harbor ------ #
resource "helm_release" "harbor" {
  name       = "harbor"
  namespace  = "harbor"
  repository = "https://helm.goharbor.io"
  version    = "1.18.3"
  chart      = "harbor"

  values = [
    file("../../../specs/deployments/harbor/values.yaml")
  ]

  set = [{
    name  = "harborAdminPassword"
    value = var.registry_password
  }]
}

# ------ authentik ------ #
resource "helm_release" "authentik" {
  name       = "authentik"
  namespace  = "authentik"
  repository = "https://charts.goauthentik.io"
  version    = "2026.2.1"
  chart      = "authentik"

  values = [
    file("../../../specs/deployments/authentik/values.yaml"),
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
