terraform {
  backend "gcs" {
    bucket = "kahnwong-tfstate"
    prefix = "terraform/kubernetes/nuc/configmaps"
  }
}
