locals {
  secrets = [
    # ------- default ------- #
    {
      name      = "firefly"
      namespace = "default"
    },
    {
      name      = "miniflux"
      namespace = "default"
    },
    {
      name      = "minio"
      namespace = "default"
    },
    {
      name      = "picoshare"
      namespace = "default"
    },
    # ------- jobs ------- #
    {
      name      = "r2"
      namespace = "jobs"
    },
    # ------- jobs-family-alerts ------- #
    {
      name      = "family-alerts"
      namespace = "jobs-family-alerts"
    }
  ]
}
locals {
  secrets_dict = { for o in local.secrets : o.name => o }
  secrets_name = toset(local.secrets[*].name)
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


resource "kubernetes_secret" "harbor_config" {
  for_each = local.namespaces

  metadata {
    name      = "harbor-cfg"
    namespace = each.key
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        (var.registry_server) = {
          "username" = var.registry_username
          "password" = var.registry_password
          "auth"     = base64encode("${var.registry_username}:${var.registry_password}")
        }
      }
    })
  }
}
