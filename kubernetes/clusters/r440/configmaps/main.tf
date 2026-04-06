locals {
  configmaps = tomap({
    infrastructure = [
      {
        source : "garage.sops.toml",
        filename : "garage.toml"
        input_type : "raw"
      },
    ]
  })
}

module "configmaps" {
  source = "../../../modules/configmaps"

  cluster_name = var.cluster_name
  configmaps   = local.configmaps
}
