locals {
  pages = toset([
    "calculator",
    "docs",
    "excalidraw",
    "face-detection",
    "gallery",
    "h3-viewer",
    "jupyterlite",
    "maps",
    "marimo",
    "monkeytype",
    "portip",
    "promptpay",
    "slc",
    "slonix",
    "swissknife",
    "textarea",
    "tldraw",
    "vendor-status",
  ])
}

module "pages" {
  for_each = local.pages

  source = "./modules/cloudflare-pages"

  account_id = var.cloudflare_account_id
  zone_id    = var.cloudflare_zone_id

  project_name = each.key
  subdomain    = "${each.key}.karnwong.me"
  domain_name  = "${each.key}.karnwong.me"
}

# custom
module "karnwong_me" {
  source = "./modules/cloudflare-pages"

  account_id = var.cloudflare_account_id
  zone_id    = var.cloudflare_zone_id

  project_name = "karnwong-me"
  subdomain    = "karnwong.me"
  domain_name  = "karnwong.me"
}

# escape `.` in project name
module "swissknife_git" {
  source = "./modules/cloudflare-pages"

  account_id = var.cloudflare_account_id
  zone_id    = var.cloudflare_zone_id

  project_name = "swissknife-git"
  subdomain    = "swissknife.git"
  domain_name  = "swissknife.git.karnwong.me"
}
