## email alias (already verified)
#resource "cloudflare_dns_record" "google_workspace_alias" {
#  name    = "@"
#  proxied = false
#  ttl     = 1
#  type    = "TXT"
#  value   = data.sops_file.secrets.data["GOOGLE_WORKSPACE_ALIAS"]
#  zone_id = local.cloudflare_zone_id
#}

resource "cloudflare_dns_record" "google_workspace_smtp" {
  name     = "karnwong.me"
  priority = 1
  proxied  = false
  ttl      = 1
  type     = "MX"
  content  = "smtp.google.com"
  zone_id  = var.cloudflare_zone_id
}
