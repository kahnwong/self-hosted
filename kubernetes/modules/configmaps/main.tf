locals {
  configmaps_map_raw = flatten([
    for namespace, configmaps in var.configmaps : [
      for configmap in configmaps : {
        namespace  = namespace
        source     = configmap.source
        filename   = configmap.filename
        input_type = lookup(configmap, "input_type", null)
      }
    ]
  ])
  configmaps_map = { for index, v in local.configmaps_map_raw : v.source => v }
}


data "sops_file" "configmaps" {
  for_each    = local.configmaps_map
  source_file = "${path.module}/../../specs/configmaps/${var.cluster_name}/${each.key}"
  input_type  = each.value.input_type
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
