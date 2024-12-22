output "cloudflare_api_token_deploy_cloudflare_pages" {
  sensitive = true
  value     = cloudflare_api_token.deploy_cloudflare_pages.value
}

output "cloudflare_api_token_ddns_updater" {
  sensitive = true
  value     = cloudflare_api_token.ddns_updater.value
}


output "cloudflare_api_token_r2_backup" {
  sensitive = true

  value = tomap({
    "access_key_id" : cloudflare_api_token.r2_backup.id,
    "secret_access_key" : sha256(cloudflare_api_token.r2_backup.value),
    }
  )
}

output "cloudflare_api_token_r2_ro" {
  sensitive = true

  value = tomap({
    "access_key_id" : cloudflare_api_token.r2_ro.id,
    "secret_access_key" : sha256(cloudflare_api_token.r2_ro.value),
    }
  )
}

output "cloudflare_api_token_r2_send_rw" {
  sensitive = true

  value = tomap({
    "access_key_id" : cloudflare_api_token.r2_send_rw.id,
    "secret_access_key" : sha256(cloudflare_api_token.r2_send_rw.value),
    }
  )
}

output "cloudflare_api_token_caddy_wildcard_tls" {
  sensitive = true
  value     = cloudflare_api_token.caddy_wildcard_tls.value
}
