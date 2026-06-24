locals {
  deployments_base = tomap({
    default = []
    authentik = [
      "authentik-postgres",
      "authentik-valkey"
    ]
    infrastructure = [
      "garage",
      "ntfy",
    ]
    tools = [
      "filebrowser",
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

# ------ authentik ------ #
resource "helm_release" "authentik" {
  name       = "authentik"
  namespace  = "authentik"
  repository = "https://charts.goauthentik.io"
  version    = "2026.5.3"
  chart      = "authentik"

  values = [
    file("../../../specs/deployments/authentik/values.yaml"),
  ]
}
