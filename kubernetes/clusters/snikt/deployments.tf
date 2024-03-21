locals {
  deployments_default = toset([
    "dashy",
    "duckdb",
    "firefly",
    #    "gatus",
    "linkding",
    "memos",
    "miniflux",
    "minio",
    "ntfy",
    "picoshare",
    "rustpad",
    "shouldideploytoday",
    "sshx",
    "supersecretmessage",
    "wallabag",
  ])

  deployments_excalidraw = toset([
    "excalidraw-room",
    "excalidraw-storage-backend",
    "excalidraw",
  ])

  deployments_forgejo = toset([
    "forgejo"
  ])
}

resource "helm_release" "ns_default" {
  for_each  = local.deployments_default
  name      = each.key
  namespace = "default"
  #  repository = "oci://harbor.karnwong.me/charts"
  repository = "oci://registry-1.docker.io/karnwong"
  version    = "0.1.0"
  chart      = "base"

  values = [
    file("./deployments/default/${each.key}.yaml")
  ]
}

resource "helm_release" "ns_excalidraw" {
  for_each   = local.deployments_excalidraw
  name       = each.key
  namespace  = "excalidraw"
  repository = "oci://registry-1.docker.io/karnwong"
  version    = "0.1.0"
  chart      = "base"

  values = [
    file("./deployments/excalidraw/${each.key}.yaml")
  ]
}

resource "helm_release" "ns_forgejo" {
  for_each   = local.deployments_forgejo
  name       = each.key
  namespace  = "forgejo"
  repository = "oci://registry-1.docker.io/karnwong"
  version    = "0.1.0"
  chart      = "base"

  values = [
    file("./deployments/forgejo/${each.key}.yaml")
  ]
}
