# to test locally, run
# helm template ntfy  ../../charts/base/chart --values helm/deployments/default/ntfy.yaml

locals {
  deployments_base = tomap({
    default = []
    immich  = ["immich", "immich-machine-learning", "immich-postgres", "immich-valkey"]
    infrastructure = [
      "authentik-valkey",
      "forgejo",
      "garage",
      "llm-honeypot",
      "ntfy",
      "trmnl",
    ]
    services = [
      # "evcc",
      "cloud",
      "cpubench",
      "dashboard",
      "fava",
      "koreader-sync-server",
      "ladder",
      "linkding",
      "livegrep-backend", "livegrep-frontend",
      "miniflux",
      "navidrome",
      "notes",
      "paperless-ngx", "paperless-ngx-valkey",
      "qrcode-api",
      "retrooo",
      "sshx",
      "subsonic-widgets",
      "supersecretmessage", "supersecretmessage-vault",
      "todotxt",
      "wabbajack",
      "wakapi",
      "wallabag", "wallabag-redis",
      "weather-api",
    ]
  })
  deployments_knative = tomap({
    infrastructure = [
      # "mlflow",  # disable until https://github.com/mlflow/mlflow/issues/24155 is fixed
    ]
    playground = [
    ]
    services = [
      "jellyfin",
      "rustpad",
      "stirling-pdf",
      "thai-tech-cal",
    ]
  })
  deployments_cloudnative_pg = tomap({
    default = [
    ]
    # harbor = ["harbor-postgres"]
    infrastructure = [
      "authentik-postgres",
      "forgejo-postgres",
      "mlflow-postgres",
    ]
    playground = ["postgres-playground"]
    services = [
      "miniflux-postgres",
      "wakapi-postgres",
      "wallabag-postgres",
    ]
  })
}

module "base" {
  source = "../../../modules/deployments"

  deployments   = local.deployments_base
  chart_name    = "base"
  chart_version = "0.4.1"
  values_extras = []
}


module "knative" {
  source = "../../../modules/deployments"

  deployments   = local.deployments_knative
  chart_name    = "base-knative"
  chart_version = "0.3.0"
  values_extras = [
    # "./resources/valuesTaintNodeSelector.yaml",
  ]
}

module "cloudnative_pg" {
  source = "../../../modules/deployments"

  deployments   = local.deployments_cloudnative_pg
  chart_name    = "cloudnative-pg"
  chart_version = "0.1.0"
  values_extras = [
    # "./resources/valuesTaintNodeSelector.yaml",
  ]
}

# ------ notes-sync ------ #
resource "kubernetes_manifest" "notes" {
  manifest = yamldecode(file("../../../specs/deployments/services/notes-sync.yaml"))
}

# # ------ harbor ------ #
# resource "helm_release" "harbor" {
#   name       = "harbor"
#   namespace  = "harbor"
#   repository = "https://helm.goharbor.io"
#   version    = "1.19.1"
#   chart      = "harbor"
#
#   values = [
#     file("../../../specs/deployments/harbor/values.yaml")
#   ]
#
#   set = [{
#     name  = "harborAdminPassword"
#     value = var.registry_password
#   }]
# }

# ------ authentik ------ #
resource "helm_release" "authentik" {
  name       = "authentik"
  namespace  = "infrastructure"
  repository = "https://charts.goauthentik.io"
  version    = "2026.5.4"
  chart      = "authentik"

  values = [
    file("../../../specs/deployments/infrastructure/authentik.values.yaml"),
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
