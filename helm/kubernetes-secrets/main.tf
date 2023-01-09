data "sops_file" "miniflux" {
  source_file = "./secrets/miniflux.sops.yaml"
}
resource "kubernetes_secret" "miniflux" {
  metadata {
    name = "miniflux"
  }

  data = {
    MINIFLUX_USER     = data.sops_file.miniflux.data["miniflux_user"]
    MINIFLUX_PASSWORD = data.sops_file.miniflux.data["miniflux_password"]
  }
}
