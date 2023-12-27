data "sops_file" "miniflux" {
  source_file = "./secrets/miniflux.sops.yaml"
}
resource "kubernetes_secret" "miniflux" {
  metadata {
    name = "miniflux"
  }

  data = nonsensitive(data.sops_file.miniflux.data)
}

data "sops_file" "photoprism" {
  source_file = "./secrets/photoprism.sops.yaml"
}
resource "kubernetes_secret" "photoprism" {
  metadata {
    name = "photoprism"
  }

  data = nonsensitive(data.sops_file.photoprism.data)
}

data "sops_file" "picoshare" {
  source_file = "./secrets/picoshare.sops.yaml"
}
resource "kubernetes_secret" "picoshare" {
  metadata {
    name = "picoshare"
  }

  data = nonsensitive(data.sops_file.picoshare.data)
}



data "sops_file" "minio" {
  source_file = "./secrets/minio.sops.yaml"
}
resource "kubernetes_secret" "minio" {
  metadata {
    name = "minio"
  }

  data = nonsensitive(data.sops_file.minio.data)
}

resource "kubernetes_secret" "harbor_config" {
  metadata {
    name = "harbor-cfg"
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.registry_server}" = {
          "username" = var.registry_username
          "password" = var.registry_password
          "auth"     = base64encode("${var.registry_username}:${var.registry_password}")
        }
      }
    })
  }
}


data "sops_file" "llm" {
  source_file = "./secrets/llm.sops.yaml"
}
resource "kubernetes_secret" "llm" {
  metadata {
    name = "llm"
  }

  data = nonsensitive(data.sops_file.llm.data)
}
