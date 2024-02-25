locals {
  jobs = toset([
    "backup-navidrome",
    "backup-prune",
    "backup-transmission",
    "email-to-epub",
  ])
}

resource "kubernetes_manifest" "jobs" {
  for_each = local.jobs

  manifest = yamldecode(file("./deployments/jobs/${each.key}.yaml"))
}
