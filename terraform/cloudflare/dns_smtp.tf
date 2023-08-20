resource "cloudflare_record" "smtp_a" {
  name    = data.sops_file.secrets.data["smtp_a_name"]
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = data.sops_file.secrets.data["smtp_a_value"]
  zone_id = data.sops_file.secrets.data["zone_id"]
}
resource "cloudflare_record" "smtp_b" {
  name    = data.sops_file.secrets.data["smtp_b_name"]
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = data.sops_file.secrets.data["smtp_b_value"]
  zone_id = data.sops_file.secrets.data["zone_id"]
}
resource "cloudflare_record" "smtp_c" {
  name    = data.sops_file.secrets.data["smtp_c_name"]
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = data.sops_file.secrets.data["smtp_c_value"]
  zone_id = data.sops_file.secrets.data["zone_id"]
}
resource "cloudflare_record" "smtp_d" {
  name    = data.sops_file.secrets.data["smtp_d_name"]
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = data.sops_file.secrets.data["smtp_d_value"]
  zone_id = data.sops_file.secrets.data["zone_id"]
}
resource "cloudflare_record" "smtp_e" {
  name    = data.sops_file.secrets.data["smtp_e_name"]
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = data.sops_file.secrets.data["smtp_e_value"]
  zone_id = data.sops_file.secrets.data["zone_id"]
}
