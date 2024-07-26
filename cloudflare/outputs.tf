output "cloudflare_api_token_deploy_cloudflare_pages" {
  sensitive = true
  value     = cloudflare_api_token.deploy_cloudflare_pages.value
}
