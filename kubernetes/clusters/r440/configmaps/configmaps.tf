# garage
data "sops_file" "garage" {
  source_file = "${path.module}/configmaps/garage.sops.toml"
  input_type  = "raw"
}
resource "kubernetes_config_map" "garage" {
  metadata {
    name      = "garage"
    namespace = "infrastructure"
  }

  data = {
    "garage.toml" = data.sops_file.garage.raw
  }

  depends_on = [data.sops_file.garage]
}
