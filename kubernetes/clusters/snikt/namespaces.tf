locals {
  namespaces = toset([
    "default",
    "immich",
    "infrastructure",
    "jobs",
    "jobs-family-alerts",
    "news",
    "tools",
  ])
}

resource "kubernetes_namespace" "this" {
  for_each = setsubtract(local.namespaces, toset(["default"]))

  metadata {
    name = each.key
  }
}
