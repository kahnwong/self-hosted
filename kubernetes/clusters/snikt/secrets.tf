locals {
  secrets = tomap({
    authentik      = ["authentik-env", "authentik-postgres"] # `authentic-env` is to prevent name collision with secrets provided by helm chart
    bots           = ["qa-api", "qa-discord-bot"]
    default        = ["subsonic-widgets"]
    immich         = ["immich", "immich-machine-learning", "immich-postgres"]
    infrastructure = ["forgejo", "forgejo-postgres", "minio", "mlflow", "mlflow-postgres"]
    news = [
      "miniflux", "miniflux-postgres",
      "wallabag", "wallabag-postgres", "wallabag-redis"
    ]
    plausible = ["plausible", "plausible-postgres"]
    jobs = [
      "backup", "ddns", "water-cut-notify",
      "authentik-postgres",
      "forgejo-postgres",
      "immich-postgres",
      "miniflux-postgres",
      "wakapi-postgres",
      "wallabag",
    ]
    jobs-family-alerts = ["family-alerts"]
    tools              = ["opengist", "picoshare", "supersecretmessage-vault", "wakapi", "wakapi-postgres"]
    woodpecker         = ["woodpecker", "woodpecker-postgres"]
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

# resource "kubernetes_secret" "harbor_config" {
#   for_each = local.namespaces
#
#   metadata {
#     name      = "harbor-cfg"
#     namespace = each.key
#   }
#
#   type = "kubernetes.io/dockerconfigjson"
#
#   data = {
#     ".dockerconfigjson" = jsonencode({
#       auths = {
#         (var.registry_server) = {
#           "username" = var.registry_username
#           "password" = var.registry_password
#           "auth"     = base64encode("${var.registry_username}:${var.registry_password}")
#         }
#       }
#     })
#   }
# }
