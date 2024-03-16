locals {
  namespaces = toset([
    "default",
    "forgejo",
    "excalidraw",
    "livegrep",
    "jobs",
    "jobs-family-alerts",
    "twentycrm",
  ])
}

resource "kubernetes_namespace" "this" {
  for_each = setsubtract(local.namespaces, toset(["default"]))

  metadata {
    name = each.key
  }
}
