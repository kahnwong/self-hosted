resource "cloudflare_record" "pop_mx_send" {
  name     = "send"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = data.sops_file.secrets.data["POP_MX_SEND"]
  zone_id  = local.cloudflare_zone_id
}

resource "cloudflare_record" "pop_txt_send" {
  name    = "send"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = data.sops_file.secrets.data["POP_TXT_SEND"]
  zone_id = local.cloudflare_zone_id
}

resource "cloudflare_record" "pop_txt_key" {
  name    = "resend._domainkey"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = data.sops_file.secrets.data["POP_TXT_KEY"]
  zone_id = local.cloudflare_zone_id
}
