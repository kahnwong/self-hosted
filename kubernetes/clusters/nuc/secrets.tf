locals {
  secrets = [

    # ------- jobs ------- #
    {
      name      = "backup"
      namespace = "jobs"
    },
  ]

  secrets_backup_jobs = [
    {
      name      = "immich-postgres"
      namespace = "jobs"
  }, ]
}
locals {
  secrets_dict = { for o in local.secrets : o.name => o }
  secrets_name = toset(local.secrets[*].name)

  secrets_backup_jobs_dict = { for o in local.secrets_backup_jobs : o.name => o }
  secrets_backup_jobs_name = toset(local.secrets_backup_jobs[*].name)
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
