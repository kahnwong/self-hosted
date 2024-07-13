locals {
  secrets = tomap({
    default            = []
    immich             = ["immich", "immich-machine-learning", "immich-postgres"]
    infrastructure     = ["forgejo", "forgejo-postgres", "minio", "mlflow", "mlflow-postgres"]
    miniflux           = ["miniflux"]
    jobs               = ["backup", "ddns", "water-cut-notify", "immich-postgres"]
    jobs-family-alerts = ["family-alerts"]
    tools              = ["picoshare"]
  })
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
  secrets_map = { for index, v in local.secrets_map_raw : "${v.namespace}-${v.secret}" => tomap(v) }
}

data "sops_file" "secrets" {
  for_each    = local.secrets_map
  source_file = "./secrets/${each.value.secret}.sops.yaml"
}
resource "kubernetes_secret" "secrets" {
  for_each = local.secrets_map

  metadata {
    name      = each.value.secret
    namespace = each.value.namespace
  }
  data = nonsensitive(data.sops_file.secrets["${each.value.namespace}-${each.value.secret}"].data)

  depends_on = [data.sops_file.secrets]
}
