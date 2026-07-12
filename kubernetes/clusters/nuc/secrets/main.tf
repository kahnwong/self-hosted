locals {
  secrets = tomap({
    analytics = []
    default   = []
    # harbor         = ["harbor"]
    infrastructure = [
      "authentik-env", # `authentic-env` is to prevent name collision with secrets provided by helm chart
      "forgejo",
      "llm-honeypot",
      "mlflow",
      "ntfy",
      "trmnl"
    ]
    jobs = [
      "backup", "ddns", "aqi-notify", "water-cut-notify",
      "authentik-postgres",
      "forgejo-postgres",
      "immich-postgres",
      "miniflux-postgres",
      "wakapi-postgres",
      "wallabag-postgres",

      # food
      "family-alerts"
    ]
    services = [
      "cpubench",
      "immich", "immich-machine-learning",
      "livegrep-clone-custom",
      "miniflux",
      "notes-sync",
      "qrcode-api",
      "retrooo",
      "subsonic-widgets",
      "supersecretmessage-vault",
      "wakapi",
      "wallabag",
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
      "immich-postgres",
      "miniflux-postgres",
      "wakapi-postgres",
      "wallabag-postgres",
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
