resource "cloudflare_dns_record" "txt" {
  name    = "@"
  proxied = false
  ttl     = 1
  type    = "TXT"
  content = data.sops_file.secrets.data["TXT_VALUE"]
  zone_id = local.cloudflare_zone_id
}

resource "cloudflare_dns_record" "mx" {
  name     = "@"
  priority = 1
  proxied  = false
  ttl      = 1
  type     = "MX"
  content  = "smtp.google.com"
  zone_id  = local.cloudflare_zone_id
}
