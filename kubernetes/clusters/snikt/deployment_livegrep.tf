resource "helm_release" "ns_livegrep" {
  name       = "livegrep"
  namespace  = "livegrep"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.1.0"
  chart      = "base"

  values = [
    file("./deployments/livegrep/livegrep.yaml")
  ]
}

resource "kubernetes_manifest" "job_livegrep" {
  manifest = yamldecode(file("./deployments/livegrep/livegrep-indexer.yaml"))
}
