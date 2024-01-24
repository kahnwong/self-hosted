locals {
  jobs = toset([
    "email-to-epub",
  ])
}

resource "kubernetes_manifest" "jobs" {
  for_each = local.jobs

  manifest = yamldecode(file("../../../kubernetes/nuc/jobs/${each.key}.yaml"))
}
