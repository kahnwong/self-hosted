locals {
  deployments_map_raw = flatten([
    for namespace, deployments in var.deployments : [
      for deployment in deployments : {
        deployment = deployment
        namespace  = namespace
      }
    ]
  ])
  deployments_map = { for index, v in local.deployments_map_raw : v.deployment => v.namespace }
}

resource "helm_release" "this" {
  for_each   = local.deployments_map
  name       = each.key
  namespace  = each.value
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = var.chart_version
  chart      = var.chart_name

  values = [
    for path in concat(["${path.module}/../../specs/deployments/${each.value}/${each.key}.yaml"], var.values_extras) :
    file(path)
  ]
}
