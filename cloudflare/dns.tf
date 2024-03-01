locals {
  #  github_pages = toset([
  #  ])
  selfhosted_proxied = toset([
    "firefly",
    "gcp-azure-cost-calculator",
    "gke-autopilot-cost-calculator",
    "linkding",
    "meetings",
    "memos",
    "miniflux",
    "music",
    "ntfy",
    "podgrab",
    "rustpad",
    "secrets",
    "photos",
    "shouldideploytoday",
    # excalidraw
    "excalidraw",
    "excalidraw-storage-backend",
    "excalidraw-room",
  ])
  selfhosted_non_proxied = setunion(toset([
    "git",
    "harbor",
    "jellyfin", # https://github.com/jellyfin/jellyfin-media-player/issues/174#issuecomment-1306167299
    "minio",
    "share", # prevent request entity too large
    "syncthing",
    "wallabag",
  ]), var.private_dns)
}
locals {
  proxied_dict     = { for name in local.selfhosted_proxied : name => true }
  non_proxied_dict = { for name in local.selfhosted_non_proxied : name => false }
  selfhosted_dns   = merge(local.proxied_dict, local.non_proxied_dict)
}

#resource "cloudflare_record" "github_pages_dns" {
#  for_each = local.github_pages
#  name     = each.key
#  proxied  = true
#  ttl      = 1
#  type     = "CNAME"
#  value    = "kahnwong.github.io"
#  zone_id  = local.cloudflare_zone_id
#}

resource "cloudflare_record" "selfhosted_dns" {
  for_each = local.selfhosted_dns
  name     = each.key
  proxied  = each.value
  ttl      = 1
  type     = "CNAME"
  value    = data.sops_file.secrets.data["DDNS_CNAME"]
  zone_id  = local.cloudflare_zone_id
}

resource "cloudflare_record" "vaultwarden" {
  name    = "vaultwarden"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "34.145.66.238"
  zone_id = local.cloudflare_zone_id
}

resource "cloudflare_record" "www_dummy" { # need for redirection
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "192.0.2.1"
  zone_id = local.cloudflare_zone_id
}
resource "cloudflare_page_rule" "redirect_www_to_root" {
  zone_id  = local.cloudflare_zone_id
  target   = "www.karnwong.me/*"
  priority = 1

  actions {
    forwarding_url {
      url         = "https://karnwong.me/$1"
      status_code = 301
    }
  }
}
