locals {
  jobs = tomap({
    jobs = [
      "backup-linkding",
      "backup-memos",
      "backup-miniflux",
      "backup-ntfy",
      "backup-prune",
      "backup-wallabag-content",
      "backup-wallabag-db",
      "ddns",
      "water-cut-notify",
    ]
    jobs-family-alerts = [
      "00-0-morning-coffee",
      "01-1-lunch-ask",
      "01-2-lunch-order",
      "02-1-dinner-ask-family",
      "02-2-dinner-update-granny",
      "02-3-coffee-or-tea",
    ]
  })

  jobs_fringe_division = toset([
    "backup-immich-db",
    "backup-navidrome",
    "backup-syncthing",
    "backup-transmission",
  ])
}

locals {
  jobs_map_raw = flatten([
    for namespace, jobs in local.jobs : [
      for job in jobs : {
        job       = job
        namespace = namespace
      }
    ]
  ])
  jobs_map = { for index, v in local.jobs_map_raw : v.job => v.namespace }
}

resource "helm_release" "jobs" {
  for_each   = local.jobs_map
  name       = each.key
  namespace  = each.value
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.1.0"
  chart      = "base-cronjob"

  values = [
    file("./helm/jobs/${each.value}/${each.key}.yaml"),
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
    file("./helm/jobs/jobs-fringe-division/${each.key}.yaml"),
    file("./resources/valuesTaintNodeSelector.yaml"),
  ]
}
