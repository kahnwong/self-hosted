locals {
  namespaces = toset([
    "default",
    # "harbor",
    "immich", # [TODO] remove
    "infrastructure",
    "jobs",
    "playground",
    "services",
  ])
}

resource "kubernetes_namespace_v1" "this" {
  for_each = setsubtract(local.namespaces, toset(["default"]))

  metadata {
    name = each.key
  }
}
