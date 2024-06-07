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

data "sops_file" "dashy" {
  source_file = "${path.module}/configmaps/dashy.sops.yml"
}
resource "kubernetes_config_map" "dashy" {
  metadata {
    name      = "dashy"
    namespace = "default"
  }

  data = {
    "conf.yml" = data.sops_file.dashy.raw
  }
}


data "sops_file" "gatus" {
  source_file = "${path.module}/configmaps/gatus.sops.yaml"
}
resource "kubernetes_config_map" "gatus" {
  metadata {
    name      = "gatus"
    namespace = "default"
  }

  data = {
    "config.yaml" = data.sops_file.gatus.raw
  }
}
