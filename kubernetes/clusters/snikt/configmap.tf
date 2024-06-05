resource "kubernetes_config_map" "ntfy" {
  metadata {
    name      = "ntfy"
    namespace = "default"
  }

  data = {
    "server.yaml" = file("${path.module}/configmaps/ntfy.server.yml")
  }

}
