locals {
  namespaces = toset([
    # "default",
    "immich",
    "infrastructure",
    "tools",
  ])
}

resource "kubernetes_namespace_v1" "this" {
  for_each = setsubtract(local.namespaces, toset(["default"]))

  metadata {
    name = each.key
  }
}
