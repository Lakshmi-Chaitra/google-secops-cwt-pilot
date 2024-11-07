#output "cloud_run_neg_ids" {
#  value = { for neg in google_compute_global_network_endpoint_group.cloud_run_neg : neg.name => neg.id }
#}


output "neg_list" {
  value = var.neg_list
}

output "cloud_run_backend_id" {
  value = google_compute_backend_service.cloud_run_backend.id
}
