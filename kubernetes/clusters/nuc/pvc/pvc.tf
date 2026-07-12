locals {
  pvcs = tomap({
    # harbor = [ # need to run `sudo chown -R 10000:10000 /opt/harbor/registry`
    #   {
    #     deployment = "harbor-registry"
    #     path       = "/opt/harbor/registry"
    #   },
    # ]
    services = [
      # ---- jellyfin ----
      {
        deployment = "jellyfin-media"
        path       = "/opt/jellyfin/media"
      },
      {
        deployment = "jellyfin-config"
        path       = "/opt/jellyfin/config"
      },
      {
        deployment = "jellyfin-sink"
        path       = "/opt/transmission/downloads/complete"
      },
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

  set = [
    {
      name  = "name"
      value = each.key
    },
    { name  = "path"
      value = each.value.path
    }
  ]
}
