variable "private_dns" {
  type = set(string)
}

variable "private_bird_dns" {
  type = set(string)
}

variable "cloudflare_api_token" {
  type = string
}

variable "cloudflare_account_id" {
  type = string
}

variable "cloudflare_zone_id" {
  type = string
}
