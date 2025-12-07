terraform {
  cloud {
    organization = "fringe-division"
    hostname     = "app.terraform.io"

    workspaces {
      tags = ["k8s-r440-configmaps"]
    }
  }
}
