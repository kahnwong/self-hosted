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
    "media",
    "news",
    "notes",
    "plausible",
    "playground",
    "tools",
    "umami",
  ])
}

resource "kubernetes_namespace" "this" {
  for_each = setsubtract(local.namespaces, toset(["default"]))

  metadata {
    name = each.key
  }
}
