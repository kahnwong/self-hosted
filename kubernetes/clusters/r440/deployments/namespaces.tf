locals {
  namespaces = toset([
    # "default",
    "authentik",
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
