data "sops_file" "miniflux" {
  source_file = "./secrets/miniflux.sops.yaml"
}
