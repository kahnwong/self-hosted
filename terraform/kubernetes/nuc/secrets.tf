locals {
  secrets = toset([
    "miniflux",
    "photoprism",
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

data "sops_file" "jobs_r2" {
  source_file = "./secrets/r2.sops.yaml"
}
resource "kubernetes_secret" "jobs_r2" {
  metadata {
    name      = "r2"
    namespace = "jobs"
  }
  data = nonsensitive(data.sops_file.jobs_r2.data)
}
