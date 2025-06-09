resource "cloudflare_dns_record" "bluesky_txt" {
  name    = "_atproto.karnwong.me"
  proxied = false
  ttl     = 1
  type    = "TXT"
  content = data.sops_file.secrets.data["BLUESKY_TXT_VALUE"]
  zone_id = var.cloudflare_zone_id
}
