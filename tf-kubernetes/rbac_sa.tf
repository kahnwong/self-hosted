# ------------------------ service account ------------------------ #
# https://github.com/hashicorp/terraform-provider-kubernetes/issues/1943#issuecomment-1369546028
resource "kubernetes_secret" "foo" {
  metadata {
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.foo.metadata.0.name
    }
    namespace = "default"
    name      = "${kubernetes_service_account.foo.metadata.0.name}-token"
  }
  type                           = "kubernetes.io/service-account-token"
  wait_for_service_account_token = true
}
resource "kubernetes_service_account" "foo" {
  metadata {
    name      = "sa-foo"
    namespace = "default"
  }
}

# ------------------------ cluster role ------------------------ #
resource "kubernetes_cluster_role" "readonly" {
  metadata {
    name = "cr-readonly"
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces", "pods", "pods/log"]
    verbs      = ["get", "list", "watch"]
  }
}

# ------------------------ cluster role binding ------------------------ #
resource "kubernetes_cluster_role_binding" "readonly" {
  metadata {
    name = "crb-readonly"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.readonly.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.foo.metadata.0.name
    namespace = "default"
  }
}
