resource "kubernetes_service_account" "cwt_service_account" {
  metadata {
    name      = var.service_account_name
    namespace = var.namespace
  }
}

resource "kubernetes_role" "cwt_role" {
  metadata {
    name      = var.role_name
    namespace = var.namespace
  }

  rule {
    api_groups = [""]
    resources  = var.resources
    verbs      = var.verbs
  }
}

resource "kubernetes_role_binding" "cwt_role_binding" {
  metadata {
    name      = var.role_binding_name
    namespace = var.namespace
  }

  role_ref {
    kind     = "Role"
    name     = kubernetes_role.cwt_role.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.cwt_service_account.metadata[0].name
    namespace = kubernetes_service_account.cwt_service_account.metadata[0].namespace
  }
}
