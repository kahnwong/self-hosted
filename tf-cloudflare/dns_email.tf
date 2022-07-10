resource "cloudflare_record" "terraform_managed_resource_143555b19652cd46080796d693da123e" {
  name     = "karnwong.me"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = data.sops_file.secrets.data["mx2"]
  zone_id  = data.sops_file.secrets.data["zone_id"]
}

resource "cloudflare_record" "terraform_managed_resource_989f8a3455d739ec043a6e073c70a1bb" {
  name     = "karnwong.me"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = data.sops_file.secrets.data["mx1"]
  zone_id  = data.sops_file.secrets.data["zone_id"]
}

resource "cloudflare_record" "terraform_managed_resource_46e88ec4e3f8942732a3a9c25ee4f83c" {
  name     = "karnwong.me"
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = data.sops_file.secrets.data["mx3"]
  zone_id  = data.sops_file.secrets.data["zone_id"]
}

resource "cloudflare_record" "terraform_managed_resource_453c42c73366d4a6878e501f564ba2b8" {
  name     = "_autodiscover._tcp"
  priority = 0
  proxied  = false
  ttl      = 1
  type     = "SRV"
  zone_id  = data.sops_file.secrets.data["zone_id"]
  data {
    name     = "karnwong.me"
    port     = 443
    priority = 0
    proto    = "_tcp"
    service  = "_autodiscover"
    target   = data.sops_file.secrets.data["autodiscover_target"]
    weight   = 0
  }
}
