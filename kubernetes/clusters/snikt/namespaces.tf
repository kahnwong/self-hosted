locals {
  namespaces = toset([
    "default",
    "excalidraw",
    "forgejo",
    "jobs",
    "jobs-family-alerts",
    "livegrep",
  ])
}

resource "kubernetes_namespace" "this" {
  for_each = setsubtract(local.namespaces, toset(["default"]))

  metadata {
    name = each.key
  }
}
