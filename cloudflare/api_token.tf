data "cloudflare_api_token_permission_groups" "all" {}
resource "cloudflare_api_token" "deploy_cloudflare_pages" {
  name = "deploy_cloudflare_pages"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.account["Pages Write"],
    ]
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }
}
