locals {
  pvcs = tomap({
    media = [
      # audiobookshelf
      {
        deployment = "audiobookshelf-config"
        path       = "/opt/audiobookshelf/config"
      },
      {
        deployment = "audiobookshelf-metadata"
        path       = "/opt/audiobookshelf/metadata"
      },
      {
        deployment = "audiobookshelf-data"
        path       = "/opt/syncthing/audiobooks"
      },
      # calibre-web
      {
        deployment = "calibre-web-config"
        path       = "/opt/calibre-web/config"
      },
      {
        deployment = "calibre-web-data"
        path       = "/opt/syncthing/books/Library"
      },
      # jellyfin
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
