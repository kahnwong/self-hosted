module "card_a" {
  source = "../../modules/cloudflare-pages"

  account_id = local.cloudflare_account_id
  zone_id    = local.cloudflare_zone_id

  project_name = var.card_a_project_name
  subdomain    = var.card_a_subdomain
  domain_name  = var.card_a_domain_name
}

