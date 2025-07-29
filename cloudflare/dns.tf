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
    "evcc",
    "ghostfolio",
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
    "split",
    "thai-tech-cal",
    "todotxt",
    "wakapi",
  ])
  selfhosted_non_proxied = setunion(toset([
    "api.todotxt",
    "audiobookshelf",
    "authentik",
    "books",
    "cli.send",
    "console.minio",
    "files",
    "garage",
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
    "subsonic-widgets",
    "syncthing",
    "t.console.notes",
    "teslamate",
    "wallabag",
    "warpgate",
    # "share", # prevent request entity too large; migrated to oracle
  ]), var.private_dns)
}
locals {
  proxied_dict     = { for name in local.selfhosted_proxied : name => true }
  non_proxied_dict = { for name in local.selfhosted_non_proxied : name => false }
  selfhosted_dns   = merge(local.proxied_dict, local.non_proxied_dict)
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

resource "cloudflare_dns_record" "vaultwarden" {
  name    = "vaultwarden.karnwong.me"
  proxied = true
  ttl     = 1
  type    = "A"
  content = data.sops_file.secrets.data["GCP_VM_IP"]
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "umami" {
  name    = "umami.karnwong.me"
  proxied = true
  ttl     = 1
  type    = "A"
  content = data.sops_file.secrets.data["GCP_VM_IP"]
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "pairdrop" {
  name    = "pairdrop.karnwong.me"
  proxied = true
  ttl     = 1
  type    = "A"
  content = data.sops_file.secrets.data["ORACLE_VM_IP"]
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "anisette" {
  name    = "anisette.karnwong.me"
  proxied = true
  ttl     = 1
  type    = "A"
  content = data.sops_file.secrets.data["ORACLE_VM_IP"]
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "kutt" {
  name    = "kutt.karnwong.me"
  proxied = true
  ttl     = 1
  type    = "A"
  content = data.sops_file.secrets.data["ORACLE_VM_IP"]
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "picoshare" {
  name    = "share.karnwong.me"
  proxied = true
  ttl     = 1
  type    = "A"
  content = data.sops_file.secrets.data["ORACLE_VM_IP"]
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "croc" {
  name    = "croc.karnwong.me"
  proxied = false
  ttl     = 1
  type    = "A"
  content = data.sops_file.secrets.data["ORACLE_VM_IP"]
  zone_id = var.cloudflare_zone_id
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
