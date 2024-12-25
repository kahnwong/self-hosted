data "cloudflare_api_token_permission_groups" "all" {}

# -------------------- Cloudflare Pages --------------------
resource "cloudflare_api_token" "deploy_cloudflare_pages" {
  name = "deploy-cloudflare-pages"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.account["Pages Write"],
    ]
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }
}

# -------------------- DNS --------------------
resource "cloudflare_api_token" "ddns_updater" {
  name = "ddns-updater"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.zone["DNS Write"],
    ]
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }
}

resource "cloudflare_api_token" "caddy_wildcard_tls" {
  name = "caddy-wildcard-tls"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.zone["Zone Read"],
      data.cloudflare_api_token_permission_groups.all.zone["DNS Write"],
    ]
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }
}

# -------------------- R2 --------------------
resource "cloudflare_api_token" "r2_backup" {
  name = "r2-backup"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.account["Workers R2 Storage Write"],
    ]
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }
}

resource "cloudflare_api_token" "r2_ro" {
  name = "r2-ro"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.account["Workers R2 Storage Read"],
    ]
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }
}

resource "cloudflare_api_token" "r2_send_rw" {
  name = "r2-send-rw"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.r2["Workers R2 Storage Bucket Item Write"],
    ]
    resources = {
      "com.cloudflare.edge.r2.bucket.${var.cloudflare_account_id}_default_send" = "*"
    }
  }
}
