locals {
  secrets = tomap({
    analytics = []
    authentik = ["authentik-env", "authentik-postgres"] # `authentic-env` is to prevent name collision with secrets provided by helm chart
    default   = []
    immich = [
      # "immich", "immich-machine-learning", "immich-postgres"
    ]
    infrastructure = [
      # "mlflow", "mlflow-postgres",
      "ntfy"
    ]
  })

  secrets_basic_auth = tomap({
    default = []
  })


  ghcr_namespaces = toset(["infrastructure"]) // placeholder for now
}



module "secrets" {
  source = "../../../modules/secrets"

  cluster_name       = var.cluster_name
  secrets            = local.secrets
  secrets_basic_auth = local.secrets_basic_auth
  ghcr_namespaces    = local.ghcr_namespaces
  ghcr_username      = var.ghcr_username
  ghcr_token         = var.ghcr_token
}
