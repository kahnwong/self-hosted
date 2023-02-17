resource "cloudflare_pages_project" "this" {
  account_id        = var.account_id
  name              = var.project_name
  production_branch = var.production_branch

  lifecycle {
    ignore_changes = [deployment_configs]
  }
}

resource "cloudflare_record" "this" {
  depends_on = [cloudflare_pages_project.this]

  name    = var.subdomain
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_pages_project.this.subdomain
  zone_id = var.zone_id
}

resource "cloudflare_pages_domain" "this" {
  depends_on = [cloudflare_record.this]

  account_id   = var.account_id
  project_name = var.project_name
  domain       = var.domain_name
}
