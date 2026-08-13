locals {
  configmaps = tomap({
    infrastructure = [
      {
        source : "garage.sops.toml",
        filename : "garage.toml"
        input_type : "raw"
      },
    ]
    services = [
      {
        source : "cloud.sops.caddyfile",
        filename : "Caddyfile",
        input_type : "raw"
      },
      {
        source : "livegrep-clone-config.sops.yaml",
        filename : "repos.yaml"
      },
    ]
  })
}

module "configmaps" {
  source = "../../../modules/configmaps"

  cluster_name = var.cluster_name
  configmaps   = local.configmaps
}
