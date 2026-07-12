locals {
  namespaces = toset([
    "default",
    # "harbor",
    "immich",
    "infrastructure",
    "jobs",
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
