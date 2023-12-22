provider "sops" {}

provider "cloudflare" {
  api_token = data.sops_file.secrets.data["CLOUDFLARE_API_TOKEN"]
}
