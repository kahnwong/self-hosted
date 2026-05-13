locals {
  secrets_map_raw = flatten([
    for namespace, secrets in var.secrets : [
      for secret in secrets : {
        secret    = secret
        namespace = namespace
      }
    ]
  ])
  secrets_map = { for index, v in local.secrets_map_raw : "${v.namespace}-${v.secret}" => tomap(v) }

  secrets_basic_auth_map_raw = flatten([
    for namespace, secrets in var.secrets_basic_auth : [
      for secret in secrets : {
        secret    = secret
        namespace = namespace
      }
    ]
  ])
  secrets_cloudnative_pg_map = { for index, v in local.secrets_basic_auth_map_raw : "${v.namespace}-${v.secret}" => tomap(v) }
}

data "sops_file" "secrets" {
  for_each    = local.secrets_map
  source_file = "${path.module}/../../specs/secrets/${var.cluster_name}/${each.value.secret}.sops.yaml"
}
resource "kubernetes_secret_v1" "secrets" {
  for_each = local.secrets_map

  metadata {
    name      = each.value.secret
    namespace = each.value.namespace
  }
  data = nonsensitive(data.sops_file.secrets["${each.value.namespace}-${each.value.secret}"].data)

  depends_on = [data.sops_file.secrets]
}

data "sops_file" "secrets_basic_auth" {
  for_each = local.secrets_cloudnative_pg_map
  // shared with `secrets` since they are stored in the same location
  source_file = "${path.module}/../../specs/secrets/${var.cluster_name}/${each.value.secret}.sops.yaml"
}
resource "kubernetes_secret_v1" "secrets_cloudnative_pg" {
  for_each = local.secrets_cloudnative_pg_map

  metadata {
    name      = each.value.secret
    namespace = each.value.namespace
  }

  type = "kubernetes.io/basic-auth"
  data = nonsensitive(data.sops_file.secrets_basic_auth["${each.value.namespace}-${each.value.secret}"].data)

  depends_on = [data.sops_file.secrets]
}


resource "kubernetes_secret_v1" "ghcr_config" {
  for_each = var.ghcr_namespaces

  metadata {
    name      = "ghcr-cfg"
    namespace = each.key
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        ("ghcr.io") = {
          "username" = var.ghcr_username
          "password" = var.ghcr_token
          "auth"     = base64encode("${var.ghcr_username}:${var.ghcr_token}")
        }
      }
    })
  }
}
