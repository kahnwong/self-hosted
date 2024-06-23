locals {
  configmaps = tomap({
    dashy = {
      namespace = "default"
      filename  = "conf.yml"
    }
    gatus = {
      namespace = "default"
      filename  = "config.yaml"
    }
    ntfy = {
      namespace = "default"
      filename  = "server.yaml",
    },
  })
}

data "sops_file" "configmaps" {
  for_each    = local.configmaps
  source_file = "${path.module}/configmaps/${each.key}.sops.yaml"
}
resource "kubernetes_config_map" "this" {
  for_each = local.configmaps

  metadata {
    name      = each.key
    namespace = each.value.namespace
  }

  data = {
    (each.value.filename) = data.sops_file.configmaps[each.key].raw
  }

  depends_on = [data.sops_file.configmaps]
}
