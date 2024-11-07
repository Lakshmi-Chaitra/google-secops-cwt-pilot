output "load_balancer_ip" {
  value = google_compute_address.external_ip.address
}

output "backend_id" {
  value = google_compute_backend_service.cloud_run_backend.id
}
