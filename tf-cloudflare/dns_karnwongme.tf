resource "cloudflare_record" "terraform_managed_resource_d7cb14251baaa29cd5c3651d97b18cf7" {
  name    = "karnwong.me"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "185.199.108.153"
  zone_id = data.sops_file.secrets.data["zone_id"]
}

resource "cloudflare_record" "terraform_managed_resource_a594b7168fa19fa9244ef416142eecda" {
  name    = "karnwong.me"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "185.199.110.153"
  zone_id = data.sops_file.secrets.data["zone_id"]
}

resource "cloudflare_record" "terraform_managed_resource_944552c366feeeaa064364ef49009bf2" {
  name    = "karnwong.me"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "185.199.111.153"
  zone_id = data.sops_file.secrets.data["zone_id"]
}

resource "cloudflare_record" "terraform_managed_resource_de18f187652a7977f6f064db4d373cda" {
  name    = "karnwong.me"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "185.199.109.153"
  zone_id = data.sops_file.secrets.data["zone_id"]
}

resource "cloudflare_record" "terraform_managed_resource_21950c2cfadc04f8b919df3259e6cf34" {
  name    = "karnwong.me"
  proxied = true
  ttl     = 1
  type    = "AAAA"
  value   = "2606:50c0:8000::153"
  zone_id = data.sops_file.secrets.data["zone_id"]
}

resource "cloudflare_record" "terraform_managed_resource_2128a112cce4bc81f4b98529f94c3428" {
  name    = "karnwong.me"
  proxied = true
  ttl     = 1
  type    = "AAAA"
  value   = "2606:50c0:8003::153"
  zone_id = data.sops_file.secrets.data["zone_id"]
}

resource "cloudflare_record" "terraform_managed_resource_48128031d1aa8beb83f911a8ce85dff6" {
  name    = "karnwong.me"
  proxied = true
  ttl     = 1
  type    = "AAAA"
  value   = "2606:50c0:8001::153"
  zone_id = data.sops_file.secrets.data["zone_id"]
}

resource "cloudflare_record" "terraform_managed_resource_6dc5c1ef3a950415d326ba2dcd679588" {
  name    = "karnwong.me"
  proxied = true
  ttl     = 1
  type    = "AAAA"
  value   = "2606:50c0:8002::153"
  zone_id = data.sops_file.secrets.data["zone_id"]
}
