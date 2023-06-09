################
# deploy key
################
resource "tls_private_key" "flux" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "this" {
  title      = "Flux"
  repository = var.github_repository
  key        = tls_private_key.flux.public_key_openssh
  read_only  = "false"
}

################
# main
################
resource "flux_bootstrap_git" "this" {
  path           = "flux"
  network_policy = true
  #   kustomization_override = file("${path.module}/kustomization.yaml")
}
