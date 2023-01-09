data "sops_file" "miniflux" {
  source_file = "./secrets/miniflux.sops.yaml"
}
resource "kubernetes_secret" "miniflux" {
  metadata {
    name = "miniflux"
  }

  data = {
    ADMIN_USERNAME = data.sops_file.miniflux.data["ADMIN_USERNAME"]
    ADMIN_PASSWORD = data.sops_file.miniflux.data["ADMIN_PASSWORD"]
  }
}

data "sops_file" "photoprism" {
  source_file = "./secrets/photoprism.sops.yaml"
}
resource "kubernetes_secret" "photoprism" {
  metadata {
    name = "photoprism"
  }

  data = {
    PHOTOPRISM_ADMIN_PASSWORD = data.sops_file.photoprism.data["PHOTOPRISM_ADMIN_PASSWORD"]
  }
}
