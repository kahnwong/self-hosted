resource "cloudflare_dns_record" "pop_mx_send" {
  name     = "send.karnwong.me"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  content  = data.sops_file.secrets.data["POP_MX_SEND"]
  zone_id  = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "pop_txt_send" {
  name    = "send.karnwong.me"
  proxied = false
  ttl     = 1
  type    = "TXT"
  content = data.sops_file.secrets.data["POP_TXT_SEND"]
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "pop_txt_key" {
  name    = "resend._domainkey.karnwong.me"
  proxied = false
  ttl     = 1
  type    = "TXT"
  content = data.sops_file.secrets.data["POP_TXT_KEY"]
  zone_id = var.cloudflare_zone_id
}
