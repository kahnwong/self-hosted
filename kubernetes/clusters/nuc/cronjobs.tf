locals {
  jobs = toset([
    "backup-immich-db",
    "backup-navidrome",
    "backup-syncthing",
    "backup-transmission",
  ])
}

resource "kubernetes_manifest" "jobs" {
  for_each = local.jobs

  manifest = yamldecode(file("./deployments/jobs/${each.key}.yaml"))
}
