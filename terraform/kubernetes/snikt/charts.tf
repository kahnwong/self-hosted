locals {
  deployments_default = toset([
    "dashy",
    "gke-autopilot-cost-calculator",
    "minio",
    "picoshare",
    "rustpad",
    "shouldideploytoday",
    "sourcegraph",
    "sshx",
    "supersecretmessage",
  ])

  deployments_excalidraw = toset([

  ])
}
resource "helm_release" "ns_default" {
  for_each   = local.deployments_default
  name       = each.key
  namespace  = "default"
  repository = "oci://harbor.karnwong.me/charts"
  version    = "0.1.0"
  chart      = "base"

  values = [
    file("../../../kubernetes/snikt/default/${each.key}.yaml")
  ]
}
