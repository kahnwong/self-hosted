locals {
  deployments = tomap({
    default = []
    infrastructure = [
      # "garage",
      "mlflow", "mlflow-postgres",
      "ntfy",
    ]

    tools = [
      "sshx",
    ]
  })
}

locals {
  deployments_map_raw = flatten([
    for namespace, deployments in local.deployments : [
      for deployment in deployments : {
        namespace  = namespace
        deployment = deployment
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
  version    = "0.2.0"
  chart      = "base"

  values = [
    file("../../../specs/deployments/${each.value}/${each.key}.yaml"),
  ]
}
