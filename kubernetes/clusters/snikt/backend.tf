terraform {
  cloud {
    organization = "fringe-division"
    hostname     = "app.terraform.io"

    workspaces {
      tags = ["kubernetes-snikt"]
    }
  }
}
