data "sops_file" "secrets" {
  source_file = "secrets.sops.yaml"
}

# sites
locals {
  cloudflare_pages_repos = toset([
    "basemaps",
    "calculator",
    "docs",
    "excalidraw",
    "food-picker",
    "gallery.karnwong.me",
    "h3-viewer",
    "jupyterlite",
    "karnwong.me",
    "marimo-wasm",
    "monkeytype",
    "promptpay-qr-code",
    "python-playground",
    "retriever",
    "slc",
    "tldraw",
    "whattheduck",
  ])

  vercel_repos = toset([
    "transform",
    "shouldideploy",
  ])
}

# static variables
locals {
  cloudflare_secrets = tomap({
    CLOUDFLARE_ACCOUNT_ID = sensitive(data.sops_file.secrets.data["global.cloudflare.CLOUDFLARE_ACCOUNT_ID"])
    CLOUDFLARE_API_TOKEN  = sensitive(data.sops_file.secrets.data["global.cloudflare.CLOUDFLARE_API_TOKEN"])
  })
  cloudflare_secrets_mapping = flatten([
    for repo in setunion(local.cloudflare_pages_repos, toset(var.private_cloudflare_pages_repos)) : [
      for secret_key, secret_value in local.cloudflare_secrets : {
        repo         = repo
        secret_key   = secret_key
        secret_value = secret_value
      }
    ]
  ])
}

locals {
  vercel_secrets = tomap({
    VERCEL_ORG_ID = sensitive(data.sops_file.secrets.data["global.vercel.VERCEL_ORG_ID"])
    VERCEL_TOKEN  = sensitive(data.sops_file.secrets.data["global.vercel.VERCEL_TOKEN"])
  })
  vercel_secrets_mapping = flatten([
    for repo in local.vercel_repos : [
      for secret_key, secret_value in local.vercel_secrets : {
        repo         = repo
        secret_key   = secret_key
        secret_value = secret_value
      }
    ]
  ])
}

locals {
  docs_algolia_secrets = tomap({
    ALGOLIA_APPLICATION_ID = sensitive(data.sops_file.secrets.data["repos.docs.ALGOLIA_APPLICATION_ID"])
    ALGOLIA_API_KEY        = sensitive(data.sops_file.secrets.data["repos.docs.ALGOLIA_API_KEY"])
  })
}

# main
resource "github_actions_secret" "cloudflare_pages" {
  for_each = {
    for i in local.cloudflare_secrets_mapping : "${i.repo}.${i.secret_key}" => i
  }

  repository      = each.value.repo
  secret_name     = each.value.secret_key
  plaintext_value = each.value.secret_value
}

resource "github_actions_secret" "vercel" {
  for_each = {
    for i in local.vercel_secrets_mapping : "${i.repo}.${i.secret_key}" => i
  }

  repository      = each.value.repo
  secret_name     = each.value.secret_key
  plaintext_value = each.value.secret_value
}

resource "github_actions_secret" "docs_algolia" {
  for_each = local.docs_algolia_secrets

  repository      = "docs"
  secret_name     = each.key
  plaintext_value = each.value
}
