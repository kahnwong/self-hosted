provider "sops" {}

provider "github" {
  token = var.github_token
  owner = "kahnwong"
}
