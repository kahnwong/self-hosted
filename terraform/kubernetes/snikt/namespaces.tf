locals {
  namespaces = toset(["default", "llm", "jobs-family-alerts"])
}

resource "kubernetes_namespace" "this" {
  for_each = setsubtract(local.namespaces, toset(["default"]))

  metadata {
    name = each.key
  }
}
