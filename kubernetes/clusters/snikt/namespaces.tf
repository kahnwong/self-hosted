locals {
  namespaces = toset([
    "default",
    "firefly",
    "forgejo",
    "jobs-family-alerts",
    "jobs",
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
