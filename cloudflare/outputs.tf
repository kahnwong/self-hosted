output "cloudflare_api_token_deploy_cloudflare_pages" {
  sensitive = true
  value     = cloudflare_api_token.deploy_cloudflare_pages.value
}

output "cloudflare_api_token_ddns_updater" {
  sensitive = true
  value     = cloudflare_api_token.ddns_updater.value
}
