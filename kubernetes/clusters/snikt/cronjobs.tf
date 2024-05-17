locals {
  jobs = toset([
    "backup-firefly-db",
    "backup-kanboard",
    "backup-linkding",
    "backup-memos",
    "backup-miniflux",
    "backup-ntfy",
    "backup-prune",
    "backup-wallabag-content",
    "backup-wallabag-db",
    "ddns",
  ])

  jobs_fringe_division = toset([
    "backup-immich-db",
    "backup-navidrome",
    "backup-syncthing",
    "backup-transmission",
  ])

  jobs_family_alerts = toset([
    "00-0-morning-coffee",
    "01-1-lunch-ask",
    "01-2-lunch-order",
    "02-1-dinner-ask-family",
    "02-2-dinner-update-granny",
    "02-3-coffee-or-tea",
  ])
}


# resource "kubernetes_manifest" "jobs" {
#   for_each = local.jobs
#
#   manifest = yamldecode(file("./jobs/jobs/${each.key}.yaml"))
# }

resource "helm_release" "jobs" {
  for_each   = local.jobs
  name       = each.key
  namespace  = "jobs"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.1.0"
  chart      = "base-cronjob"

  values = [
    file("./jobs/jobs/${each.key}.yaml"),
  ]
}

resource "helm_release" "jobs_fringe_division" {
  for_each   = local.jobs_fringe_division
  name       = each.key
  namespace  = "jobs"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.1.0"
  chart      = "base-cronjob"

  values = [
    file("./jobs/jobs-fringe-division/${each.key}.yaml"),
    file("valuesTaintNodeSelector.yaml"),
  ]
}

resource "helm_release" "family_alerts" {
  for_each   = local.jobs_family_alerts
  name       = each.key
  namespace  = "jobs-family-alerts"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.1.0"
  chart      = "base-cronjob"

  values = [
    file("./jobs/jobs-family-alerts/${each.key}.yaml"),
  ]
}
