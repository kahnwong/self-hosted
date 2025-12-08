locals {
  namespaces = toset([
    # "default",
    "immich",
    "infrastructure",
    "tools",
  ])
}

resource "kubernetes_namespace" "this" {
  for_each = setsubtract(local.namespaces, toset(["default"]))

  metadata {
    name = each.key
  }
}
