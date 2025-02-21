locals {
  jobs = tomap({
    jobs = []
  })

  jobs_fringe_division = tomap({
    jobs = [
      "backup-authentik",
      "backup-beaverhabits",
      "backup-forgejo-data",
      "backup-forgejo-db",
      "backup-immich-db",
      "backup-linkding",
      "backup-memos",
      "backup-microbin",
      "backup-miniflux",
      "backup-navidrome",
      "backup-nocodb",
      "backup-ntfy",
      "backup-rally",
      "backup-slash",
      # "backup-syncthing",
      "backup-transmission",
      "backup-wakapi",
      "backup-wallabag-content",
      "backup-wallabag-db",
      "ddns",
      "maintenance-backup-monthly-prune",
      "maintenance-backup-prune",
      "maintenance-wallabag-cleanup",
      "restart-livegrep",
      "water-cut-notify",
    ]

    jobs-family-alerts = [
      "01-1-lunch-ask",
      "01-2-lunch-order",
      # "01-3-check-order",
      "02-1-dinner-ask-family",
      # "02-2-dinner-order",
    ]
  })
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

  jobs_fringe_division_map_raw = flatten([
    for namespace, jobs in local.jobs_fringe_division : [
      for job in jobs : {
        job       = job
        namespace = namespace
      }
    ]
  ])
  jobs_fringe_division_map = { for index, v in local.jobs_fringe_division_map_raw : v.job => v.namespace }
}

resource "helm_release" "jobs" {
  for_each   = local.jobs_map
  name       = each.key
  namespace  = each.value
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.1.0"
  chart      = "base-cronjob"

  values = [
    file("./jobs/${each.value}/${each.key}.yaml"),
  ]
}

resource "helm_release" "jobs_fringe_division" {
  for_each   = local.jobs_fringe_division_map
  name       = each.key
  namespace  = each.value
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.1.0"
  chart      = "base-cronjob"

  values = [
    file("./jobs/${each.value}/${each.key}.yaml"),
    # file("./resources/valuesTaintNodeSelector.yaml"),
  ]
}

# livegrep
data "sops_file" "livegrep" {
  source_file = "./jobs/jobs/livegrep-indexer.sops.yaml"
}
resource "helm_release" "livegrep_indexer" {
  name       = "livegrep-indexer"
  namespace  = "tools"
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.1.0"
  chart      = "base-cronjob"

  values = [
    data.sops_file.livegrep.raw,
    # file("./resources/valuesTaintNodeSelector.yaml"),
  ]
}
