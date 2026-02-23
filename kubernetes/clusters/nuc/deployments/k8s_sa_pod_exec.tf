# ------------------------ service account ------------------------ #
resource "kubernetes_secret_v1" "pod_exec" {
  metadata {
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account_v1.pod_exec.metadata.0.name
    }
    namespace = "jobs"
    name      = "${kubernetes_service_account_v1.pod_exec.metadata.0.name}-token"
  }
  type                           = "kubernetes.io/service-account-token"
  wait_for_service_account_token = true
}
resource "kubernetes_service_account_v1" "pod_exec" {
  metadata {
    name      = "sa-pod-exec"
    namespace = "jobs"
  }
}

# ------------------------ cluster role ------------------------ #
resource "kubernetes_cluster_role_v1" "pod_exec" {
  metadata {
    name = "cr-pod-exec"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "pods/log"]
    verbs      = ["get", "list"]
  }
  rule {
    api_groups = [""]
    resources  = ["pods/exec"]
    verbs      = ["create"]
  }
}

# ------------------------ cluster role binding ------------------------ #
resource "kubernetes_cluster_role_binding_v1" "pod_exec" {
  metadata {
    name = "crb-pod-exec"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.pod_exec.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.pod_exec.metadata.0.name
    namespace = "jobs"
  }
}
