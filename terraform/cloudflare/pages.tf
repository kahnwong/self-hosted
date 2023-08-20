locals {
  account_id = data.sops_file.secrets.data["account_id"]
  zone_id    = data.sops_file.secrets.data["zone_id"]
}

module "docs" {
  source = "./modules/cloudflare-pages"

  account_id = local.account_id
  zone_id    = local.zone_id

  project_name = "docs"
  subdomain    = "docs"
  domain_name  = "docs.karnwong.me"
}

module "karnwong_me" {
  source = "./modules/cloudflare-pages"

  account_id = local.account_id
  zone_id    = local.zone_id

  project_name = "karnwong-me"
  subdomain    = "www"
  domain_name  = "www.karnwong.me"
}
