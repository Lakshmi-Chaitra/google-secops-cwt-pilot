output "service_account_name" {
  value = kubernetes_service_account.cwt_service_account.metadata[0].name
}
