data "sops_file" "secrets" {
  source_file = "secrets.sops.yaml"
}

locals {
  cloudflare_pages_repos = toset([
    "docs",
    "karnwong.me",
  ])
  cloudflare_secrets = tomap({
    CLOUDFLARE_ACCOUNT_ID = sensitive(data.sops_file.secrets.data["global.cloudflare.CLOUDFLARE_ACCOUNT_ID"])
    CLOUDFLARE_API_TOKEN  = sensitive(data.sops_file.secrets.data["global.cloudflare.CLOUDFLARE_API_TOKEN"])
  })
  cloudflare_secrets_mapping = flatten([
    for repo in local.cloudflare_pages_repos : [
      for secret_key, secret_value in local.cloudflare_secrets : {
        repo         = repo
        secret_key   = secret_key
        secret_value = secret_value
      }
    ]
  ])
}
resource "github_actions_secret" "cloudflare_pages" {
  for_each = {
    for i in local.cloudflare_secrets_mapping : "${i.repo}.${i.secret_key}" => i
  }

  repository      = each.value.repo
  secret_name     = each.value.secret_key
  plaintext_value = each.value.secret_value
}

locals {
  docs_algolia_secrets = tomap({
    ALGOLIA_APPLICATION_ID = sensitive(data.sops_file.secrets.data["repos.docs.ALGOLIA_APPLICATION_ID"])
    ALGOLIA_API_KEY        = sensitive(data.sops_file.secrets.data["repos.docs.ALGOLIA_API_KEY"])
  })
}
resource "github_actions_secret" "docs_algolia" {
  for_each = local.docs_algolia_secrets

  repository      = "docs"
  secret_name     = each.key
  plaintext_value = each.value
}

locals {
  pgconn_secrets = tomap({
    PYPI_API_TOKEN = sensitive(data.sops_file.secrets.data["repos.pgconn.PYPI_API_TOKEN"])
  })
}
resource "github_actions_secret" "pgconn" {
  for_each = local.pgconn_secrets

  repository      = "pgconn"
  secret_name     = each.key
  plaintext_value = each.value
}
