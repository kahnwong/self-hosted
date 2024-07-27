variable "github_token" {
  type        = string
  description = "need for github auth"
}

variable "private_cloudflare_pages_repos" {
  type = set(string)
}
