locals {
  jobs = toset([
    "backup-linkding",
    "backup-miniflux",
    "backup-navidrome",
    "backup-ntfy",
    "backup-prune",
    "backup-transmission",
    "backup-wallabag-content",
    "backup-wallabag-db",
    "email-to-epub",
  ])
}

resource "kubernetes_manifest" "jobs" {
  for_each = local.jobs

  manifest = yamldecode(file("../../../kubernetes/nuc/jobs/${each.key}.yaml"))
}
