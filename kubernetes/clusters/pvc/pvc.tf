locals {
  pvcs = tomap({
    tools = [
      {
        deployment = "linkding"
        path       = "/opt/linkding/data"
      },
      {
        deployment = "opengist"
        path       = "/opt/opengist/data"
      },
      {
        deployment = "picoshare",
        path       = "/opt/picoshare/data"
      }
    ]
  })
}

locals {
  pvcs_map_raw = flatten([
    for namespace, pvcs in local.pvcs : [
      for pvc in pvcs : {
        namespace  = namespace
        deployment = pvc.deployment
        path       = pvc.path
      }
    ]
  ])
  pvcs_map = { for index, v in local.pvcs_map_raw : v.deployment => v }
}


resource "helm_release" "this" {
  for_each   = local.pvcs_map
  name       = "${each.key}-pvc"
  namespace  = each.value.namespace
  repository = "oci://ghcr.io/kahnwong/charts"
  version    = "0.2.0"
  chart      = "base-pvc"

  set {
    name  = "name"
    value = each.key
  }
  set {
    name  = "path"
    value = each.value.path
  }
}
