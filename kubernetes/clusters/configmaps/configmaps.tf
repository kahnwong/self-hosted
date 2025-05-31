locals {
  configmaps = tomap({
    tools = [
    ]
    infrastructure = [
      {
        deployment = "gatus"
        filename   = "config.yaml"
      },
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
resource "kubernetes_config_map" "configmaps" {
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

# # plausible
# resource "kubernetes_config_map" "plausible_clickhouse_config" {
#   metadata {
#     name      = "plausible-clickhouse-config"
#     namespace = "plausible"
#   }
#
#   data = {
#     "clickhouse-config.xml" = file("${path.module}/configmaps/plausible.clickhouse-config.xml")
#   }
# }
# resource "kubernetes_config_map" "plausible_clickhouse_user_config" {
#   metadata {
#     name      = "plausible-clickhouse-user-config"
#     namespace = "plausible"
#   }
#
#   data = {
#     "clickhouse-user-config.xml" = file("${path.module}/configmaps/plausible.clickhouse-user-config.xml")
#   }
# }

# livegrep
# data "sops_file" "livegrep-ignorelist" {
#   source_file = "${path.module}/configmaps/livegrep.ignorelist.sops.txt"
#   input_type  = "raw"
# }
# resource "kubernetes_config_map" "livegrep-ignorelist" {
#   metadata {
#     name      = "livegrep-ignorelist"
#     namespace = "tools"
#   }
#
#   data = {
#     "ignorelist.txt" = data.sops_file.livegrep-ignorelist.raw
#   }
#
#   depends_on = [data.sops_file.livegrep-ignorelist]
# }

data "sops_file" "livegrep-config" {
  source_file = "${path.module}/configmaps/livegrep.config.sops.yaml"
}
resource "kubernetes_config_map" "livegrep-config" {
  metadata {
    name      = "livegrep-clone-config"
    namespace = "tools"
  }

  data = {
    "repos.yaml" = data.sops_file.livegrep-config.raw
  }

  depends_on = [data.sops_file.livegrep-config]
}

# evcc
data "sops_file" "evcc" {
  source_file = "${path.module}/configmaps/evcc.sops.yaml"
}
resource "kubernetes_config_map" "evcc" {
  metadata {
    name      = "evcc"
    namespace = "tools"
  }

  data = {
    "evcc.yaml" = data.sops_file.evcc.raw
  }

  depends_on = [data.sops_file.evcc]
}

# # sourcebot
# data "sops_file" "sourcebot_config" {
#   source_file = "${path.module}/configmaps/sourcebot.config.sops.json"
# }
# resource "kubernetes_config_map" "sourcebot_config" {
#   metadata {
#     name      = "sourcebot-config"
#     namespace = "tools"
#   }
#
#   data = {
#     "config.json" = data.sops_file.sourcebot_config.raw
#   }
#
#   depends_on = [data.sops_file.sourcebot_config]
# }
