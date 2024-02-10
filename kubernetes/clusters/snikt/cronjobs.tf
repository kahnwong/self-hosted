locals {
  jobs = toset([
    "backup-linkding",
    "backup-ntfy",
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


resource "kubernetes_manifest" "jobs" {
  for_each = local.jobs

  manifest = yamldecode(file("./deployments/jobs/${each.key}.yaml"))
}

resource "kubernetes_manifest" "family_alerts" {
  for_each = local.jobs_family_alerts

  manifest = yamldecode(file("./deployments/jobs-family-alerts/${each.key}.yaml"))
}