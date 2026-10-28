locals {
  namespaces = toset([
    "agent-sandboxes",
    "jobs",
    "default",
    # "harbor",
    "services",
    "playground",
    "infrastructure",
  ])
}

resource "kubernetes_namespace_v1" "this" {
  for_each = setsubtract(local.namespaces, toset(["default"]))

  metadata {
    name = each.key
  }
}
