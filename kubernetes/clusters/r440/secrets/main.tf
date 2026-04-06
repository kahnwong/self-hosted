locals {
  secrets = tomap({
    analytics      = []
    authentik      = ["authentik-env", "authentik-postgres"] # `authentic-env` is to prevent name collision with secrets provided by helm chart
    default        = []
    immich         = ["immich", "immich-machine-learning", "immich-postgres"]
    infrastructure = ["mlflow", "mlflow-postgres", "ntfy"]
  })

  ghcr_namespaces = toset(["infrastructure"]) // placeholder for now
}



module "secrets" {
  source = "../../../modules/secrets"

  cluster_name    = var.cluster_name
  secrets         = local.secrets
  ghcr_namespaces = local.ghcr_namespaces
  ghcr_username   = var.ghcr_username
  ghcr_token      = var.ghcr_token
}
