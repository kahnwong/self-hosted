locals {
  #  deployments_default = toset([
  #    "dashy",
  #    "gke-autopilot-cost-calculator",
  #    "minio",
  #    "picoshare",
  #    "rustpad",
  #    "shouldideploytoday",
  #    "sourcegraph",
  #    "sshx",
  #    "supersecretmessage",
  #  ])
}

#resource "helm_release" "ns_default" {
#  for_each   = local.deployments_default
#  name       = each.key
#  namespace  = "default"
#  repository = "oci://harbor.karnwong.me/charts"
#  version    = "0.1.0"
#  chart      = "base"
#
#  values = [
#    file("../../../kubernetes/snikt/default/${each.key}.yaml")
#  ]
#}
#
#resource "helm_release" "ns_excalidraw" {
#  for_each   = local.deployments_excalidraw
#  name       = each.key
#  namespace  = "excalidraw"
#  repository = "oci://harbor.karnwong.me/charts"
#  version    = "0.1.0"
#  chart      = "base"
#
#  values = [
#    file("../../../kubernetes/snikt/excalidraw/${each.key}.yaml")
#  ]
#}
#
#resource "helm_release" "ns_forgejo" {
#  for_each   = local.deployments_forgejo
#  name       = each.key
#  namespace  = "forgejo"
#  repository = "oci://harbor.karnwong.me/charts"
#  version    = "0.1.0"
#  chart      = "base"
#
#  values = [
#    file("../../../kubernetes/snikt/forgejo/${each.key}.yaml")
#  ]
#}

resource "helm_release" "harbor" {
  name       = "harbor"
  namespace  = "harbor"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  version    = "19.2.1"
  chart      = "harbor"

  values = [
    file("../../../kubernetes/nuc/harbor/values.yaml")
  ]

  set {
    name  = "adminPassword"
    value = var.registry_password
  }
}
