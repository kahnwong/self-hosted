locals {
  pages = toset([
    "calculator",
    "docs",
    "h3-viewer",
    "jupyterlite",
    "retriever",
    "slc",
  ])
}

module "karnwong_me" {
  source = "./modules/cloudflare-pages"

  account_id = local.cloudflare_account_id
  zone_id    = local.cloudflare_zone_id

  project_name = "karnwong-me"
  subdomain    = "@"
  domain_name  = "karnwong.me"
}

module "pages" {
  for_each = local.pages

  source = "./modules/cloudflare-pages"

  account_id = local.cloudflare_account_id
  zone_id    = local.cloudflare_zone_id

  project_name = each.key
  subdomain    = each.key
  domain_name  = "${each.key}.karnwong.me"
}
