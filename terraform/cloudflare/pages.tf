module "docs" {
  source = "./modules/cloudflare-pages"

  account_id = local.cloudflare_account_id
  zone_id    = local.cloudflare_zone_id

  project_name = "docs"
  subdomain    = "docs"
  domain_name  = "docs.karnwong.me"
}

module "karnwong_me" {
  source = "./modules/cloudflare-pages"

  account_id = local.cloudflare_account_id
  zone_id    = local.cloudflare_zone_id

  project_name = "karnwong-me"
  subdomain    = "@"
  domain_name  = "karnwong.me"
}

module "h3_viewer" {
  source = "./modules/cloudflare-pages"

  account_id = local.cloudflare_account_id
  zone_id    = local.cloudflare_zone_id

  project_name = "h3-viewer"
  subdomain    = "h3-viewer"
  domain_name  = "h3-viewer.karnwong.me"
}


module "slc" {
  source = "./modules/cloudflare-pages"

  account_id = local.cloudflare_account_id
  zone_id    = local.cloudflare_zone_id

  project_name = "slc"
  subdomain    = "slc"
  domain_name  = "slc.karnwong.me"
}
