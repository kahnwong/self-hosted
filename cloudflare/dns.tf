locals {
  github_pages = toset([
    "duckdb",
    "postgres",
  ])
  vercel = toset([
    "gitreceipt",
    "transform",
    "shouldideploytoday",
  ])
  selfhosted_proxied = toset([
    "*",
    "digger",
    "evcc",
    "gist",
    "go",
    "habits",
    "immich",
    "jupyterhub",
    "linkding",
    "memos",
    "microbin",
    "miniflux",
    "music",
    "nocodb",
    "ntfy",
    "pdf",
    "pmtiles",
    "qa-api",
    "rally",
    "rustpad",
    "secrets",
    "send",
    "signoz",
    "slash",
    "split",
    "thai-tech-cal",
    "todotxt",
    "wakapi",
  ])
  selfhosted_non_proxied = setunion(toset([
    "audiobookshelf",
    "authentik",
    "books",
    "cli.send",
    "console.minio",
    "files",
    "gatus",
    "git",
    "grafana.teslamate",
    "harbor",
    "headscale",
    "homer",
    "jellyfin", # https://github.com/jellyfin/jellyfin-media-player/issues/174#issuecomment-1306167299
    "k.console.notes",
    "livegrep",
    "minio",
    "mlflow",
    "notes",
    "podgrab",
    "share", # prevent request entity too large
    # "sourcebot",
    "subsonic-widgets",
    "syncthing",
    "t.console.notes",
    "teslamate",
    "wallabag",
    "wg",
  ]), var.private_dns)
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
  content  = "kahnwong.github.io"
  zone_id  = var.cloudflare_zone_id
}

resource "cloudflare_record" "vercel_dns" {
  for_each = local.vercel
  name     = each.key
  proxied  = true
  ttl      = 1
  type     = "CNAME"
  content  = "cname.vercel-dns.com."
  zone_id  = var.cloudflare_zone_id
}

resource "cloudflare_record" "selfhosted_dns" {
  for_each = local.selfhosted_dns
  name     = each.key
  proxied  = each.value
  ttl      = 1
  type     = "CNAME"
  content  = data.sops_file.secrets.data["DDNS_CNAME"]
  zone_id  = var.cloudflare_zone_id
}

resource "cloudflare_record" "vaultwarden" {
  name    = "vaultwarden"
  proxied = true
  ttl     = 1
  type    = "A"
  content = data.sops_file.secrets.data["GCP_VM_IP"]
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "umami" {
  name    = "umami"
  proxied = true
  ttl     = 1
  type    = "A"
  content = data.sops_file.secrets.data["GCP_VM_IP"]
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "matrix" {
  name    = "matrix"
  proxied = true
  ttl     = 1
  type    = "A"
  content = data.sops_file.secrets.data["ORACLE_VM_IP"]
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "pairdrop" {
  name    = "pairdrop"
  proxied = true
  ttl     = 1
  type    = "A"
  content = data.sops_file.secrets.data["ORACLE_VM_IP"]
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "kutt" {
  name    = "kutt"
  proxied = true
  ttl     = 1
  type    = "A"
  content = data.sops_file.secrets.data["ORACLE_VM_IP"]
  zone_id = var.cloudflare_zone_id
}

# need for redirection
resource "cloudflare_record" "www_dummy" {
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "A"
  content = "192.0.2.1"
  zone_id = var.cloudflare_zone_id
}
resource "cloudflare_page_rule" "redirect_www_to_root" {
  zone_id  = var.cloudflare_zone_id
  target   = "www.karnwong.me/*"
  priority = 1

  actions {
    forwarding_url {
      url         = "https://karnwong.me/$1"
      status_code = 301
    }
  }
}
