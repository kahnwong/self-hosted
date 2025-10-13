locals {
  github_pages = toset([
    "duckdb",
    "postgres",
  ])
  vercel = toset([
    "transform",
    "shouldideploytoday",
  ])
  selfhosted_proxied = toset([
    "*",
    "files",
    "ghostfolio",
    "go",
    "harbor",
    "homebox",
    "immich",
    "jupyterhub",
    "miniflux",
    "music",
    "nocodb",
    "ntfy",
    "pmtiles", # if use docker-caddy, it needs to be a separate instance because it uses `file_server` directive
    "qa-api",
    "rally",
    "rustpad",
    "subsonic-widgets",
    "thai-tech-cal",
    "todotxt",
    "wakapi",
    "wallabag",
  ])
  selfhosted_non_proxied = setunion(toset([
    "api.qrcode",
    "api.todotxt",
    "api.weather",
    "audiobookshelf",
    "authentik",
    "books",
    "cpubench",
    "garage",
    "git",
    "headscale",
    "homer",
    "jellyfin", # https://github.com/jellyfin/jellyfin-media-player/issues/174#issuecomment-1306167299
    "k.console.notes",
    "linkding",
    "livegrep",
    "mlflow",
    "notes",
    "np",
    "paperless",
    "pdf",
    "syncthing",
    "t.console.notes",
    "warpgate",
  ]), var.private_dns)

  gcp_proxied = toset([
    "vaultwarden",
    "umami",
  ])
  gcp_non_proxied = toset([])

  oracle_proxied = toset([
    "anisette",
    "gatus",
    "kutt",
    "pairdrop",
    "secrets",
  ])
  oracle_non_proxied = toset([
    "memos",
    "relay.iroh",
    "share", # prevent request entity too large
  ])
}
locals {
  # on-prem
  proxied_dict     = { for name in local.selfhosted_proxied : name => true }
  non_proxied_dict = { for name in local.selfhosted_non_proxied : name => false }
  selfhosted_dns   = merge(local.proxied_dict, local.non_proxied_dict)

  # gcp
  gcp_proxied_dict     = { for name in local.gcp_proxied : name => true }
  gcp_non_proxied_dict = { for name in local.gcp_non_proxied : name => false }
  gcp_dns              = merge(local.gcp_proxied_dict, local.gcp_non_proxied_dict)

  # oracle
  oracle_proxied_dict     = { for name in local.oracle_proxied : name => true }
  oracle_non_proxied_dict = { for name in local.oracle_non_proxied : name => false }
  oracle_dns              = merge(local.oracle_proxied_dict, local.oracle_non_proxied_dict)
}

resource "cloudflare_dns_record" "github_pages_dns" {
  for_each = local.github_pages
  name     = "${each.key}.karnwong.me"
  proxied  = true
  ttl      = 1
  type     = "CNAME"
  content  = "kahnwong.github.io"
  zone_id  = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "vercel_dns" {
  for_each = local.vercel
  name     = "${each.key}.karnwong.me"
  proxied  = true
  ttl      = 1
  type     = "CNAME"
  content  = "cname.vercel-dns.com"
  zone_id  = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "selfhosted_dns" {
  for_each = local.selfhosted_dns
  name     = "${each.key}.karnwong.me"
  proxied  = each.value
  ttl      = 1
  type     = "CNAME"
  content  = nonsensitive(data.sops_file.secrets.data["DDNS_CNAME"])
  zone_id  = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "gcp_dns" {
  for_each = local.gcp_dns
  name     = "${each.key}.karnwong.me"
  proxied  = each.value
  ttl      = 1
  type     = "A"
  content  = data.sops_file.secrets.data["GCP_VM_IP"]
  zone_id  = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "oracle_dns" {
  for_each = local.oracle_dns
  name     = "${each.key}.karnwong.me"
  proxied  = each.value
  ttl      = 1
  type     = "A"
  content  = data.sops_file.secrets.data["ORACLE_VM_IP"]
  zone_id  = var.cloudflare_zone_id
}


# need for redirection
resource "cloudflare_dns_record" "www_dummy" {
  name    = "www.karnwong.me"
  proxied = true
  ttl     = 1
  type    = "A"
  content = "192.0.2.1"
  zone_id = var.cloudflare_zone_id
}
resource "cloudflare_page_rule" "redirect_www_to_root" {
  status = "active"

  zone_id  = var.cloudflare_zone_id
  target   = "www.karnwong.me/*"
  priority = 1

  actions = {
    forwarding_url = {
      url         = "https://karnwong.me/$1"
      status_code = 301
    }
  }
}
