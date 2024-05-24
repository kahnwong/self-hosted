locals {
  namespaces = toset([
    "default",
    "forgejo",
    "harbor",
    "immich",
    "jobs",
    "jobs-family-alerts",
    "livegrep",
    "miniflux",
    "supersecretmessage",
    "wallabag",
  ])
}

resource "kubernetes_namespace" "this" {
  for_each = setsubtract(local.namespaces, toset(["default"]))

  metadata {
    name = each.key
  }
}
