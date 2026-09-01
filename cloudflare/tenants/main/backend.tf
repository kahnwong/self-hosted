terraform {
  backend "gcs" {
    bucket = "kahnwong-tfstate"
    prefix = "terraform/cloudflare/karnwong-me"
  }
}
