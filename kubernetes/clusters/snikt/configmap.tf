resource "kubernetes_config_map" "ntfy" {
  metadata {
    name      = "ntfy"
    namespace = "default"
  }

  data = {
    "server.yaml" = file("${path.module}/configmaps/ntfy.server.yml")
  }
}


data "sops_file" "ddns" {
  source_file = "${path.module}/configmaps/cloudflare.sh.sops"
  input_type  = "raw"
}
resource "kubernetes_config_map" "ddns" {
  metadata {
    name      = "ddns"
    namespace = "jobs"
  }

  data = {
    "cloudflare.sh" = data.sops_file.ddns.raw
  }
}
