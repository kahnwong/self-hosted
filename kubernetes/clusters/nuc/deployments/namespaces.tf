locals {
  namespaces = toset([
    "analytics",
    "authentik",
    "default",
    "harbor",
    "immich",
    "infrastructure",
    "jobs",
    "jobs-food",
    "media",
    "news",
    "notes",
    "playground",
    "tools",
  ])
}

resource "kubernetes_namespace_v1" "this" {
  for_each = setsubtract(local.namespaces, toset(["default"]))

  metadata {
    name = each.key
  }
}
