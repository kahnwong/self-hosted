locals {
  namespaces = toset([
    "harbor",
    "jobs"
  ])
}


resource "kubernetes_namespace" "this" {
  for_each = setsubtract(local.namespaces, toset(["default"]))

  metadata {
    name = each.key
  }
}
