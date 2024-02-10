locals {
  namespaces = toset([
    "default",
    "forgejo",
    "excalidraw",
    # "llm",
    "jobs",
    "jobs-family-alerts"
  ])
}

resource "kubernetes_namespace" "this" {
  for_each = setsubtract(local.namespaces, toset(["default"]))

  metadata {
    name = each.key
  }
}