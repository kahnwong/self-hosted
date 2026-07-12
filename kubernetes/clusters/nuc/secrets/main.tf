locals {
  secrets = tomap({
    analytics = []
    default   = []
    # harbor         = ["harbor"]
    immich = ["immich", "immich-machine-learning", "immich-postgres"]
    infrastructure = [
      "authentik-env", # `authentic-env` is to prevent name collision with secrets provided by helm chart
      "forgejo",
      "llm-honeypot",
      "mlflow",
      "ntfy",
      "trmnl"
    ]
    news = [
      "miniflux", "miniflux-postgres",
      "wallabag", "wallabag-postgres",
    ]
    jobs = [
      "backup", "ddns", "aqi-notify", "water-cut-notify",
      "authentik-postgres",
      "forgejo-postgres",
      "immich-postgres",
      "miniflux-postgres",
      "wakapi-postgres",
      "wallabag",

      # food
      "family-alerts"
    ]
    services = [
      "cpubench",
      "livegrep-clone-custom",
      "notes-sync",
      "qrcode-api",
      "retrooo",
      "subsonic-widgets",
      "supersecretmessage-vault",
      "wakapi",
      "weather-api",
    ]
  })

  secrets_basic_auth = tomap({
    default = []
    # harbor = ["harbor-postgres"]
    infrastructure = [
      "authentik-postgres",
      "forgejo-postgres",
      "mlflow-postgres"
    ]
    playground = ["postgres-playground"]
    services = [
      "wakapi-postgres",
    ]
  })

  ghcr_namespaces = toset(["infrastructure", "services", "jobs"])
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
