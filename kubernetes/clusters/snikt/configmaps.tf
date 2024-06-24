locals {
  configmaps = tomap({
    default = [
      {
        deployment = "dashy"
        filename   = "conf.yml"
      },
      {
        deployment = "gatus"
        filename   = "config.yaml"
      },
      {
        deployment = "ntfy"
        filename   = "server.yaml"
      }
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
