data "sops_file" "miniflux" {
  source_file = "./secrets/miniflux.sops.yaml"
}
resource "kubernetes_secret" "miniflux" {
  metadata {
    name = "miniflux"
  }

  data = {
    ADMIN_USERNAME = data.sops_file.miniflux.data["ADMIN_USERNAME"]
    ADMIN_PASSWORD = data.sops_file.miniflux.data["ADMIN_PASSWORD"]
  }
}

data "sops_file" "photoprism" {
  source_file = "./secrets/photoprism.sops.yaml"
}
resource "kubernetes_secret" "photoprism" {
  metadata {
    name = "photoprism"
  }

  data = {
    PHOTOPRISM_ADMIN_PASSWORD = data.sops_file.photoprism.data["PHOTOPRISM_ADMIN_PASSWORD"]
  }
}

data "sops_file" "picoshare" {
  source_file = "./secrets/picoshare.sops.yaml"
}
resource "kubernetes_secret" "picoshare" {
  metadata {
    name = "picoshare"
  }

  data = {
    PS_SHARED_SECRET = data.sops_file.picoshare.data["PS_SHARED_SECRET"]
  }
}

data "sops_file" "transmission" {
  source_file = "./secrets/transmission.sops.yaml"
}
resource "kubernetes_secret" "transmission" {
  metadata {
    name = "transmission"
  }

  data = {
    TRANSMISSION_PASSWORD = data.sops_file.transmission.data["TRANSMISSION_PASSWORD"]
  }
}

data "sops_file" "minio" {
  source_file = "./secrets/minio.sops.yaml"
}
resource "kubernetes_secret" "minio" {
  metadata {
    name = "minio"
  }

  data = {
    MINIO_ROOT_USER     = data.sops_file.minio.data["MINIO_ROOT_USER"]
    MINIO_ROOT_PASSWORD = data.sops_file.minio.data["MINIO_ROOT_PASSWORD"]
  }
}
