locals {
  jobs = toset([
    "backup-memos",
    "backup-miniflux",
    "backup-navidrome",
    "backup-prune",
    "backup-transmission",
    "backup-wallabag-content",
    "backup-wallabag-db",
    "email-to-epub",
  ])
}

resource "kubernetes_manifest" "jobs" {
  for_each = local.jobs

  manifest = yamldecode(file("./deployments/jobs/${each.key}.yaml"))
}
