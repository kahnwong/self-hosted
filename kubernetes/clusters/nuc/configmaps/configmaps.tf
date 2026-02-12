locals {
  configmaps = tomap({
    tools = [
      # { deployment : "evcc",
      #   filename : "evcc.yaml"
      # }
    ]
    infrastructure = [
    ]
  })
}

locals {
  configmaps_map_raw = flatten([
    for namespace, configmaps in local.configmaps : [
      for configmap in configmaps : {
        namespace  = namespace
        deployment = configmap.deployment
        filename   = configmap.filename
      }
    ]
  ])
  configmaps_map = { for index, v in local.configmaps_map_raw : v.deployment => v }
}


data "sops_file" "configmaps" {
  for_each    = local.configmaps_map
  source_file = "${path.module}/configmaps/${each.key}.sops.yaml"
}
resource "kubernetes_config_map_v1" "configmaps" {
  for_each = local.configmaps_map

  metadata {
    name      = each.key
    namespace = each.value.namespace
  }

  data = {
    (each.value.filename) = data.sops_file.configmaps[each.key].raw
  }

  depends_on = [data.sops_file.configmaps]
}


data "sops_file" "livegrep-config" {
  source_file = "${path.module}/configmaps/livegrep.config.sops.yaml"
}
resource "kubernetes_config_map_v1" "livegrep-config" {
  metadata {
    name      = "livegrep-clone-config"
    namespace = "tools"
  }

  data = {
    "repos.yaml" = data.sops_file.livegrep-config.raw
  }

  depends_on = [data.sops_file.livegrep-config]
}


# garage
data "sops_file" "garage" {
  source_file = "${path.module}/configmaps/garage.sops.toml"
  input_type  = "raw"
}
resource "kubernetes_config_map_v1" "garage" {
  metadata {
    name      = "garage"
    namespace = "infrastructure"
  }

  data = {
    "garage.toml" = data.sops_file.garage.raw
  }

  depends_on = [data.sops_file.garage]
}

# paperless
data "sops_file" "paperless" {
  source_file = "${path.module}/configmaps/paperless.sops.conf"
  input_type  = "raw"
}
resource "kubernetes_config_map_v1" "paperless" {
  metadata {
    name      = "paperless"
    namespace = "tools"
  }

  data = {
    "paperless.conf" = data.sops_file.paperless.raw
  }

  depends_on = [data.sops_file.paperless]
}
