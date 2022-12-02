locals {
  github_pages = toset(["www", "blog", "dashboard", "jupyterlite", ])
  selfhosted_proxied = toset([
    "linkding", "miniflux", "secrets", "ttrss", "wallabag", "budget",
    "photos", "comics", "jellyfin", "music", "syncthing", "sourcegraph", "podgrab",
    "work-dashboard", "status", "basemaps",
    "ed"
  ])
  selfhosted_non_proxied = toset([])
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
