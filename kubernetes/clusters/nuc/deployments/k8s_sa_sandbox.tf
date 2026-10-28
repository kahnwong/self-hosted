# ------------------------ service account ------------------------ #
resource "kubernetes_service_account_v1" "sandbox" {
  metadata {
    name      = "sa-sandbox"
    namespace = "agent-sandboxes"
  }
}

resource "kubernetes_secret_v1" "sandbox_token" {
  metadata {
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account_v1.sandbox.metadata.0.name
    }
    namespace = "agent-sandboxes"
    name      = "${kubernetes_service_account_v1.sandbox.metadata.0.name}-token"
  }
  type                           = "kubernetes.io/service-account-token"
  wait_for_service_account_token = true
}

# ------------------------ role (scoped to namespace) ------------------------ #
resource "kubernetes_role_v1" "sandbox" {
  metadata {
    name      = "role-sandbox"
    namespace = "agent-sandboxes"
  }

  rule {
    api_groups = ["", "apps", "batch", "networking.k8s.io"]
    resources  = ["*"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  rule {
    api_groups = ["agents.x-k8s.io"]
    resources  = ["sandboxes", "sandboxes/status"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }

  rule {
    api_groups = [""]
    resources  = ["pods/exec"]
    verbs      = ["create"]
  }
}

# ------------------------ role binding ------------------------ #
resource "kubernetes_role_binding_v1" "sandbox" {
  metadata {
    name      = "rb-sandbox"
    namespace = "agent-sandboxes"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.sandbox.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.sandbox.metadata.0.name
    namespace = "agent-sandboxes"
  }
}
