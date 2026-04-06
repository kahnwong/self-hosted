locals {
  configmaps = tomap({
    infrastructure = [
      {
        source : "garage.sops.toml",
        filename : "garage.toml"
        input_type : "raw"
      },
    ]
    tools = [
      {
        source : "livegrep-clone-config.sops.yaml",
        filename : "repos.yaml"
      },
      {
        source : "paperless.sops.conf",
        filename : "paperless.conf"
        input_type : "raw"
      }
    ]
  })
}

module "configmaps" {
  source = "../../../modules/configmaps"

  cluster_name = var.cluster_name
  configmaps   = local.configmaps
}
