locals {
  r2_buckets = toset([
    "backup",
    "public",
    "wallabag",
  ])
}

resource "cloudflare_r2_bucket" "this" {
  for_each = local.r2_buckets

  account_id = var.cloudflare_account_id
  name       = each.key
  location   = "APAC"
}
