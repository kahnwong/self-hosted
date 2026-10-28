locals {
  secrets = tomap({
    analytics = []
    default   = []
    # harbor         = ["harbor"]
    infrastructure = [
      "authentik-env", # `authentic-env` is to prevent name collision with secrets provided by helm chart
      "bifrost",
      "forgejo",
      "llm-honeypot",
      "mlflow",
      "ntfy",
      "trmnl"
    ]
    jobs = [
      # backup
      "backup",
      "authentik-postgres",
      "forgejo-postgres",
      "immich-postgres",
      "miniflux-postgres",
      "wakapi-postgres",

      # the rest
      "ddns",
      "livegrep-clone-custom",
      "notify",
      "readeck-cleanup",
    ]
    services = [
      "cpubench",
      "freellmapi",
      "fusion",
      "golinks",
      "immich", "immich-machine-learning",
      "miniflux",
      "notes-sync",
      "opengist",
      "qrcode-api",
      "readeck",
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
      "immich-postgres",
      "miniflux-postgres",
      "wakapi-postgres",
    ]
  })

  ghcr_namespaces = toset(["agent-sandboxes", "infrastructure", "services", "jobs"])
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
