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

resource "cloudflare_api_token" "ddns_updater" {
  name = "ddns_updater"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.zone["DNS Write"],
    ]
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }
}

resource "cloudflare_api_token" "r2_backup" {
  name = "r2_backup"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.account["Workers R2 Storage Write"],
    ]
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }
}
