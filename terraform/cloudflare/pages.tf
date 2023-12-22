locals {
  cloudflare_account_id = data.sops_file.secrets.data["CLOUDFLARE_ACCOUNT_ID"]
  cloudflare_zone_id    = data.sops_file.secrets.data["CLOUDFLARE_ZONE_ID"]
}

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
