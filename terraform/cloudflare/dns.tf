locals {
  github_pages = toset([
    "jupyterlite",
  ])
  selfhosted_proxied = toset([
    "api-docs",
    "budget",
    "gke-autopilot-cost-calculator",
    "linkding",
    "miniflux",
    "music",
    "ntfy",
    "photos",
    "podgrab",
    "rustpad",
    "secrets",
    "sourcegraph",
    "syncthing",
    "tile",
    "ttrss",
  ])
  selfhosted_non_proxied = toset([
    "jellyfin",  # https://github.com/jellyfin/jellyfin-media-player/issues/174#issuecomment-1306167299
    "mapserver", # [TODO] rename to `map`
    "registry",
    "share", # prevent request entity too large
    "storage",
    "wallabag",
  ])
}
locals {
  proxied_dict     = { for name in local.selfhosted_proxied : name => true }
  non_proxied_dict = { for name in local.selfhosted_non_proxied : name => false }
  selfhosted_dns   = merge(local.proxied_dict, local.non_proxied_dict)
}

resource "cloudflare_record" "github_pages_dns" {
  for_each = local.github_pages
  name     = each.key
  proxied  = true
  ttl      = 1
  type     = "CNAME"
  value    = "kahnwong.github.io"
  zone_id  = data.sops_file.secrets.data["zone_id"]
}

resource "cloudflare_record" "selfhosted_dns" {
  for_each = local.selfhosted_dns
  name     = each.key
  proxied  = each.value
  ttl      = 1
  type     = "CNAME"
  value    = data.sops_file.secrets.data["ddns"]
  zone_id  = data.sops_file.secrets.data["zone_id"]
}

resource "cloudflare_record" "standardnotes_listed" {
  name    = "listed"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "18.205.249.107"
  zone_id = data.sops_file.secrets.data["zone_id"]
}

resource "cloudflare_record" "root_dummy" { # need for redirection to www
  name    = "karnwong.me"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "192.0.2.1"
  zone_id = data.sops_file.secrets.data["zone_id"]
}
resource "cloudflare_page_rule" "redirect_to_www" {
  zone_id  = data.sops_file.secrets.data["zone_id"]
  target   = "karnwong.me/*"
  priority = 1

  actions {
    forwarding_url {
      url         = "https://www.karnwong.me/$1"
      status_code = 301
    }
  }
}
