terraform {
  backend "gcs" {
    bucket = "kahnwong-tfstate"
    prefix = "terraform/kubernetes/r440/deployments"
  }
}
