locals {
  secrets = tomap({
    default = ["minio", "picoshare"]
  })

  secrets_old = [
    # ------- immich ------- #
    {
      name      = "immich-postgres"
      namespace = "immich"
    },
    {
      name      = "immich"
      namespace = "immich"
    },
    {
      name      = "immich-machine-learning"
      namespace = "immich"
    },
    # ------- miniflux ------- #
    {
      name      = "miniflux"
      namespace = "miniflux"
    },
    # ------- jobs ------- #
    {
      name      = "backup"
      namespace = "jobs"
    },
    {
      name      = "ddns"
      namespace = "jobs"
    },
    {
      name      = "water-cut-notify"
      namespace = "jobs"
    },
    # ------- jobs-family-alerts ------- #
    {
      name      = "family-alerts"
      namespace = "jobs-family-alerts"
    }
  ]

  secrets_backup_jobs = [
    {
      name      = "immich-postgres"
      namespace = "jobs"
    },
  ]
}
locals {
  secrets_dict = { for o in local.secrets_old : o.name => o }
  secrets_name = toset(local.secrets_old[*].name)

  secrets_backup_jobs_dict = { for o in local.secrets_backup_jobs : o.name => o }
  secrets_backup_jobs_name = toset(local.secrets_backup_jobs[*].name)
}

locals {
  secrets_map_raw = flatten([
    for namespace, secrets in local.secrets : [
      for secret in secrets : {
        secret    = secret
        namespace = namespace
      }
    ]
  ])
  secrets_map = { for index, v in local.secrets_map_raw : v.secret => v.namespace }
}

data "sops_file" "secrets" {
  for_each    = local.secrets_map
  source_file = "./secrets/${each.key}.sops.yaml"
}
resource "kubernetes_secret" "secrets" {
  for_each = local.secrets_map

  metadata {
    name      = each.key
    namespace = each.value
  }
  data = nonsensitive(data.sops_file.secrets[each.key].data)

  depends_on = [data.sops_file.secrets]
}

data "sops_file" "this" {
  for_each    = local.secrets_name
  source_file = "./secrets/${each.key}.sops.yaml"
}
resource "kubernetes_secret" "this" {
  for_each = local.secrets_name

  metadata {
    name      = each.key
    namespace = local.secrets_dict[each.key]["namespace"]
  }
  data = nonsensitive(data.sops_file.this[each.key].data)
}

resource "kubernetes_secret" "backup_jobs" {
  for_each = local.secrets_backup_jobs_name

  metadata {
    name      = each.key
    namespace = local.secrets_backup_jobs_dict[each.key]["namespace"]
  }
  data = nonsensitive(data.sops_file.this[each.key].data)
}
