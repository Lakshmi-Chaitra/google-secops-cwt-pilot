# Google Compute Global Address (Static IP)
resource "google_compute_global_address" "static_ip" {
  name = var.ip_name
}

# Output the static IP address
output "address" {
  value = google_compute_global_address.static_ip.address
}
