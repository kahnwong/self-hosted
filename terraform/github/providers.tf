provider "sops" {}

provider "github" {
  token = data.sops_file.secrets.data["GITHUB_TOKEN"]
  owner = "kahnwong"
}
