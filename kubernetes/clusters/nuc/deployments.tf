locals {
  deployments_immich = toset([
    "immich",
    "immich-machine-learning",
    "immich-postgres",
    "immich-valkey",
  ])
}

resource "helm_release" "harbor" {
  name       = "harbor"
  namespace  = "harbor"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  version    = "21.1.1"
  chart      = "harbor"

  values = [
    file("./deployments/harbor/values.yaml")
  ]

  set {
    name  = "adminPassword"
    value = var.registry_password
  }
}

resource "helm_release" "immich" {
  for_each   = local.deployments_immich
  name       = each.key
  namespace  = "immich"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.2.0"
  chart      = "base"

  values = [
    file("./deployments/immich/${each.value}.yaml")
  ]
}
