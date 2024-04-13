locals {
  deployments_default = toset([
    "dashy",
    "linkding",
    "memos",
    "minio",
    "ntfy",
    "picoshare",
    "rustpad",
    "shouldideploytoday",
    "sshx",
    #     "supersecretmessage",
    "traggo",
  ])

  deployments_firefly = toset([
    "firefly",
    "firefly-postgres",
  ])

  deployments_forgejo = toset([
    "forgejo",
    "forgejo-postgres"
  ])

  deployments_livegrep = toset([
    "livegrep-backend",
    "livegrep-frontend"
  ])

  deployments_miniflux = toset([
    "miniflux",
    "miniflux-postgres"
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
    file("./deployments/default/${each.key}.yaml")
  ]
}

resource "helm_release" "ns_firefly" {
  for_each   = local.deployments_firefly
  name       = each.key
  namespace  = "firefly"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.2.0"
  chart      = "base"

  values = [
    file("./deployments/firefly/${each.key}.yaml")
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
    file("./deployments/forgejo/${each.key}.yaml")
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
    file("./deployments/livegrep/${each.key}.yaml")
  ]
}
resource "kubernetes_manifest" "job_livegrep" {
  manifest = yamldecode(file("./deployments/livegrep/livegrep-indexer.yaml"))
}

resource "helm_release" "ns_miniflux" {
  for_each   = local.deployments_miniflux
  name       = each.key
  namespace  = "miniflux"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.2.0"
  chart      = "base"

  values = [
    file("./deployments/miniflux/${each.key}.yaml")
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
    file("./deployments/wallabag/${each.key}.yaml")
  ]
}
