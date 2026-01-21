# -------------------- Cloudflare Pages --------------------
resource "cloudflare_api_token" "deploy_cloudflare_pages" {
  name   = "deploy-cloudflare-pages"
  status = "active"

  policies = [
    {
      effect = "allow"
      permission_groups = [
        {
          # data.cloudflare_api_token_permission_groups.all.account["Pages Write"]
          id = "8d28297797f24fb8a0c332fe0866ec89"
        }
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.${var.cloudflare_account_id}" = "*"
      })
    }
  ]
}

# -------------------- DNS --------------------
resource "cloudflare_api_token" "ddns_updater" {
  name   = "ddns-updater"
  status = "active"

  policies = [
    {
      effect = "allow"
      permission_groups = [
        {
          # data.cloudflare_api_token_permission_groups.all.zone["DNS Write"]
          id = "4755a26eedb94da69e1066d98aa820be"
        }
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.${var.cloudflare_account_id}" = "*"
      })
    }
  ]
}

resource "cloudflare_api_token" "caddy_wildcard_tls" {
  name   = "caddy-wildcard-tls"
  status = "active"

  policies = [
    {
      effect = "allow"
      permission_groups = [
        {
          # data.cloudflare_api_token_permission_groups.all.zone["Zone Read"]
          id = "c8fed203ed3043cba015a93ad1616f1f"
        },
        {
          #  data.cloudflare_api_token_permission_groups.all.zone["DNS Write"]
          id = "4755a26eedb94da69e1066d98aa820be"
        }
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.${var.cloudflare_account_id}" = "*"
      })
    }
  ]
}

# -------------------- R2 --------------------
resource "cloudflare_api_token" "r2_backup" {
  name   = "r2-backup"
  status = "active"

  policies = [
    {
      effect = "allow"
      permission_groups = [
        {
          # data.cloudflare_api_token_permission_groups.all.account["Workers R2 Storage Write"],
          id = "bf7481a1826f439697cb59a20b22293e"
        }
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.${var.cloudflare_account_id}" = "*"
      })
    }
  ]
}

resource "cloudflare_api_token" "r2_ro" {
  name   = "r2-ro"
  status = "active"

  policies = [
    {
      effect = "allow"
      permission_groups = [
        {
          # data.cloudflare_api_token_permission_groups.all.account["Workers R2 Storage Read"]
          id = "b4992e1108244f5d8bfbd5744320c2e1"
        }
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.${var.cloudflare_account_id}" = "*"
      })
    }
  ]
}

resource "cloudflare_api_token" "r2_send_rw" {
  name   = "r2-send-rw"
  status = "active"

  policies = [
    {
      effect = "allow"
      permission_groups = [
        {
          # data.cloudflare_api_token_permission_groups.all.r2["Workers R2 Storage Bucket Item Write"],
          id = "2efd5506f9c8494dacb1fa10a3e7d5b6"
        }
      ]
      resources = jsonencode({
        "com.cloudflare.edge.r2.bucket.${var.cloudflare_account_id}_default_send" = "*"
      })
    }
  ]
}

resource "cloudflare_api_token" "r2_restic_rw" {
  name   = "r2-restic-rw"
  status = "active"

  policies = [
    {
      effect = "allow"
      permission_groups = [
        {
          # data.cloudflare_api_token_permission_groups.all.r2["Workers R2 Storage Bucket Item Write"]
          id = "2efd5506f9c8494dacb1fa10a3e7d5b6"
        }
      ]
      resources = jsonencode({
        "com.cloudflare.edge.r2.bucket.${var.cloudflare_account_id}_default_restic" = "*"
      })
    }
  ]
}

resource "cloudflare_api_token" "r2_terraform_state_rw" {
  name   = "r2-terraform-state-rw"
  status = "active"

  policies = [
    {
      effect = "allow"
      permission_groups = [
        {
          # data.cloudflare_api_token_permission_groups.all.r2["Workers R2 Storage Bucket Item Write"],
          id = "2efd5506f9c8494dacb1fa10a3e7d5b6"
        }
      ]
      resources = jsonencode({
        "com.cloudflare.edge.r2.bucket.${var.cloudflare_account_id}_default_terraform-state" = "*"
      })
    }
  ]
}
