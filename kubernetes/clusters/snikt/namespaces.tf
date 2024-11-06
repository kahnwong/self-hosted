locals {
  namespaces = toset([
    "authentik",
    "bots",
    "default",
    "harbor",
    "immich",
    "infrastructure",
    "jobs",
    "jobs-family-alerts",
    "news",
    "notes",
    "plausible",
    "tools",
  ])
}

resource "kubernetes_namespace" "this" {
  for_each = setsubtract(local.namespaces, toset(["default"]))

  metadata {
    name = each.key
  }
}
