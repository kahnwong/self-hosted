locals {
  account_id        = data.sops_file.secrets.data["account_id"]
  project_name      = "docs"
  production_branch = "master"
  domain_name       = "docs.karnwong.me"
}


#############
# Project
#############
resource "cloudflare_pages_project" "docs" {
  account_id        = local.account_id
  name              = local.project_name
  production_branch = local.production_branch

  build_config {
    web_analytics_tag   = "/y224zpVq0juV7R1QSfDcshL4yOuy1aV" # can be any random string
    web_analytics_token = "U+q+gyJF5/G90gzbOAG9aUk+83ucJX5P" # can be any random string
  }
}

#############
# DNS
#############
resource "cloudflare_record" "docs" {
  depends_on = [cloudflare_pages_project.docs]

  name    = local.project_name
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_pages_project.docs.subdomain
  zone_id = data.sops_file.secrets.data["zone_id"]
}

# # run apply with this block to create custom domain
# # it would throw "error creating domain" error
# # ignore and remove this block from terraform state
# resource "cloudflare_pages_domain" "docs" {
#   # need to pass validation via the web UI button before you can proceed further

#   depends_on = [cloudflare_record.docs]

#   account_id   = local.account_id
#   project_name = local.project_name
#   domain       = local.domain_name
# }
