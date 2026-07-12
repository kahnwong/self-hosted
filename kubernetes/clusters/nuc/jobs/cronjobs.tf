locals {
  jobs = tomap({
    jobs = [
      "aqi-notify",
      "backup-authentik",
      "backup-forgejo-data",
      "backup-forgejo-db",
      "backup-immich-db",
      "backup-linkding",
      "backup-miniflux",
      "backup-navidrome",
      "backup-ntfy",
      "backup-paperless-ngx",
      "backup-transmission",
      "backup-wakapi",
      "backup-wallabag-content",
      "backup-wallabag-db",
      "ddns",
      "livegrep-restart",
      "maintenance-backup-monthly-prune",
      "maintenance-backup-prune",
      "maintenance-wallabag-cleanup",
      "water-cut-notify",

      # food
      "food-01-1-lunch-ask",
      "food-01-2-lunch-order",
      "food-02-1-dinner-ask",
    ]
    services = [
      "livegrep-clone",
      "livegrep-indexer-custom",
    ]
  })
}


module "base" {
  source = "../../../modules/jobs"

  jobs          = local.jobs
  chart_name    = "base-cronjob"
  chart_version = "0.2.0"
  values_extras = []
}
