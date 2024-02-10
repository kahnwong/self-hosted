provider "helm" {
  kubernetes {
    host = var.host

    client_certificate     = base64decode(var.client_certificate)
    client_key             = base64decode(var.client_key)
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }

  registry {
    url      = "oci://${var.registry_server}"
    username = var.registry_username
    password = var.registry_password
  }
}

provider "kubernetes" {
  host = var.host

  client_certificate     = base64decode(var.client_certificate)
  client_key             = base64decode(var.client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

provider "sops" {}
