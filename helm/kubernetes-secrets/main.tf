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
