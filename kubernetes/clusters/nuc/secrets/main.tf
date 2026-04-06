locals {
  secrets = tomap({
    analytics      = []
    authentik      = ["authentik-env", "authentik-postgres"] # `authentic-env` is to prevent name collision with secrets provided by helm chart
    default        = []
    harbor         = ["harbor", "harbor-postgres"]
    immich         = ["immich", "immich-machine-learning", "immich-postgres"]
    infrastructure = ["forgejo", "forgejo-postgres", "llm-honeypot", "mlflow", "mlflow-postgres", "ntfy"]
    news = [
      "miniflux", "miniflux-postgres",
      "wallabag", "wallabag-postgres", "wallabag-redis"
    ]
    notes = ["notes-sync"]
    jobs = [
      "backup", "ddns", "aqi-notify", "water-cut-notify",
      "authentik-postgres",
      "forgejo-postgres",
      "immich-postgres",
      "miniflux-postgres",
      "rallly-postgres",
      "wakapi-postgres",
      "wallabag",
    ]
    jobs-family-alerts = ["family-alerts"]
    tools = [
      "cpubench",
      "livegrep-clone-custom",
      "qrcode-api",
      "rallly", "rallly-postgres",
      "retrooo",
      "subsonic-widgets",
      "supersecretmessage-vault",
      "wakapi", "wakapi-postgres",
      "weather-api",
    ]
  })

  ghcr_namespaces = toset(["infrastructure", "tools", "jobs"])
}

module "secrets" {
  source = "../../../modules/secrets"

  cluster_name    = var.cluster_name
  secrets         = local.secrets
  ghcr_namespaces = local.ghcr_namespaces
  ghcr_username   = var.ghcr_username
  ghcr_token      = var.ghcr_token
}
