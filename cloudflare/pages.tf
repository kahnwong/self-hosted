locals {
  pages = toset([
    "calculator",
    "docs",
    "h3-viewer",
    "jupyterlite",
    "maps",
    "monkeytype",
    "python",
    "retriever",
    "slc",
    "whattheduck",
  ])
}

module "pages" {
  for_each = local.pages

  source = "./modules/cloudflare-pages"

  account_id = var.cloudflare_account_id
  zone_id    = var.cloudflare_zone_id

  project_name = each.key
  subdomain    = each.key
  domain_name  = "${each.key}.karnwong.me"
}

# custom
module "karnwong_me" {
  source = "./modules/cloudflare-pages"

  account_id = var.cloudflare_account_id
  zone_id    = var.cloudflare_zone_id

  project_name = "karnwong-me"
  subdomain    = "@"
  domain_name  = "karnwong.me"
}
module "karnwong_me_dev" {
  source = "./modules/cloudflare-pages"

  account_id = var.cloudflare_account_id
  zone_id    = var.cloudflare_zone_id

  project_name = "karnwong-me-dev"
  subdomain    = "dev"
  domain_name  = "dev.karnwong.me"
}
