# ------------------------ service account ------------------------ #
resource "kubernetes_secret" "deployment_restart" {
  metadata {
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.deployment_restart.metadata.0.name
    }
    namespace = "jobs"
    name      = "${kubernetes_service_account.deployment_restart.metadata.0.name}-token"
  }
  type                           = "kubernetes.io/service-account-token"
  wait_for_service_account_token = true
}
resource "kubernetes_service_account" "deployment_restart" {
  metadata {
    name      = "sa-deployment-restart"
    namespace = "jobs"
  }
}

# ------------------------ cluster role ------------------------ #
resource "kubernetes_cluster_role" "deployment_restart" {
  metadata {
    name = "cr-deployment-restart"
  }

  rule {
    api_groups     = ["apps", "extensions"]
    resources      = ["deployments"]
    resource_names = ["livegrep-backend"]
    verbs          = ["get", "patch", "list", "watch"]
  }
}

# ------------------------ cluster role binding ------------------------ #
resource "kubernetes_cluster_role_binding" "readonly" {
  metadata {
    name = "crb-deployment-restart"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.deployment_restart.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.deployment_restart.metadata.0.name
    namespace = "jobs"
  }
}
