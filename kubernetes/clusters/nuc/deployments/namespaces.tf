locals {
  namespaces = toset([
    "analytics",
    "authentik",
    "default",
    "harbor",
    "immich",
    "infrastructure",
    "jobs",
    "jobs-family-alerts",
    "media",
    "news",
    "notes",
    "playground",
    "tools",
  ])
}

resource "kubernetes_namespace" "this" {
  for_each = setsubtract(local.namespaces, toset(["default"]))

  metadata {
    name = each.key
  }
}
