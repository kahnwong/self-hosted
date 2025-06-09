resource "cloudflare_pages_project" "this" {
  account_id        = var.account_id
  name              = var.project_name
  production_branch = var.production_branch

  lifecycle {
    ignore_changes = [deployment_configs, source, build_config]
  }
}

resource "cloudflare_dns_record" "this" {
  depends_on = [cloudflare_pages_project.this]

  name    = var.subdomain
  proxied = true
  ttl     = 1
  type    = "CNAME"
  content = cloudflare_pages_project.this.subdomain
  zone_id = var.zone_id
}

resource "cloudflare_pages_domain" "this" {
  depends_on = [cloudflare_dns_record.this]

  account_id   = var.account_id
  project_name = var.project_name
  name         = var.domain_name
}
