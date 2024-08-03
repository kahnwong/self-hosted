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

module "karnwong_me" {
  source = "./modules/cloudflare-pages"

  account_id = var.cloudflare_account_id
  zone_id    = var.cloudflare_zone_id

  project_name = "karnwong-me"
  subdomain    = "@"
  domain_name  = "karnwong.me"
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
