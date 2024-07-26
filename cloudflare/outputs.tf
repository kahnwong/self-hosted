output "cloudflare_api_token_deploy_cloudflare_pages" {
  sensitive = true
  value     = cloudflare_api_token.deploy_cloudflare_pages.value
}

output "cloudflare_api_token_ddns_updater" {
  sensitive = true
  value     = cloudflare_api_token.ddns_updater.value
}

output "cloudflare_api_token_r2_backup_access_key_id" {
  sensitive = true
  value     = cloudflare_api_token.r2_backup.id
}
output "cloudflare_api_token_r2_backup_secret_access_key" {
  sensitive = true
  value     = sha256(cloudflare_api_token.r2_backup.value)
}
