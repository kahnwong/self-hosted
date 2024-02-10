data "sops_file" "secrets" {
  source_file = "secrets.sops.yaml"
}

locals {
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_zone_id    = var.cloudflare_zone_id
}
