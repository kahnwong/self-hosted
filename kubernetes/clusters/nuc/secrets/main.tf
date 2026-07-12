locals {
  secrets = tomap({
    analytics = []
    authentik = ["authentik-env"] # `authentic-env` is to prevent name collision with secrets provided by helm chart
    default   = []
    # harbor         = ["harbor"]
    immich         = ["immich", "immich-machine-learning", "immich-postgres"]
    infrastructure = ["forgejo", "llm-honeypot", "mlflow", "ntfy", "trmnl"]
    news = [
      "miniflux", "miniflux-postgres",
      "wallabag", "wallabag-postgres",
    ]
    notes = ["notes-sync"]
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
    tools = [
      "cpubench",
      "livegrep-clone-custom",
      "qrcode-api",
      "retrooo",
      "subsonic-widgets",
      "supersecretmessage-vault",
      "trek",
      "wakapi", "wakapi-postgres",
      "weather-api",
    ]
  })

  secrets_basic_auth = tomap({
    default   = []
    authentik = ["authentik-postgres"]
    # harbor = ["harbor-postgres"]
    infrastructure = ["forgejo-postgres", "mlflow-postgres"]
    playground     = ["postgres-playground"]
  })

  ghcr_namespaces = toset(["infrastructure", "tools", "jobs"])
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
