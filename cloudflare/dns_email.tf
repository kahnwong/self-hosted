resource "cloudflare_record" "terraform_managed_resource_143555b19652cd46080796d693da123e" {
  name     = "karnwong.me"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = data.sops_file.secrets.data["MAILBOX_MX2"]
  zone_id  = local.cloudflare_zone_id
}

resource "cloudflare_record" "terraform_managed_resource_989f8a3455d739ec043a6e073c70a1bb" {
  name     = "karnwong.me"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = data.sops_file.secrets.data["MAILBOX_MX1"]
  zone_id  = local.cloudflare_zone_id
}

resource "cloudflare_record" "terraform_managed_resource_46e88ec4e3f8942732a3a9c25ee4f83c" {
  name     = "karnwong.me"
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = data.sops_file.secrets.data["MAILBOX_MX3"]
  zone_id  = local.cloudflare_zone_id
}

resource "cloudflare_record" "terraform_managed_resource_453c42c73366d4a6878e501f564ba2b8" {
  name     = "_autodiscover._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = local.cloudflare_zone_id
  data {
    name     = "karnwong.me"
    port     = 443
    priority = 0
    proto    = "_tcp"
    service  = "_autodiscover"
    target   = data.sops_file.secrets.data["MAILBOX_AUTODISCOVER_TARGET"]
    weight   = 0
  }
}
