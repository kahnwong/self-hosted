locals {
  secrets = toset([
    "llm",
    "minio",
    "picoshare",
  ])
}

data "sops_file" "this" {
  for_each    = local.secrets
  source_file = "./secrets/${each.key}.sops.yaml"
}
resource "kubernetes_secret" "this" {
  for_each = local.secrets

  metadata {
    name = each.key
  }
  data = nonsensitive(data.sops_file.this[each.key].data)
}


data "sops_file" "kitchenowl" {
  source_file = "./secrets/kitchenowl.sops.yaml"
}
resource "kubernetes_secret" "kitchenowl" {
  metadata {
    name      = "kitchenowl"
    namespace = "kitchenowl"
  }
  data = nonsensitive(data.sops_file.kitchenowl.data)
}

resource "kubernetes_secret" "harbor_config" {
  metadata {
    name = "harbor-cfg"
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.registry_server}" = {
          "username" = var.registry_username
          "password" = var.registry_password
          "auth"     = base64encode("${var.registry_username}:${var.registry_password}")
        }
      }
    })
  }
}
