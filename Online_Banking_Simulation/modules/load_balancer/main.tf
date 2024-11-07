# Backend service for Cloud Run
resource "google_compute_backend_service" "cloud_run_backend" {
  name                 = "cloud-run-backend"
  protocol             = "HTTP"
  load_balancing_scheme = "EXTERNAL"

  dynamic "backend" {
    for_each = var.neg_list

    content {
      group = backend.value
    }
  }

  health_checks = [google_compute_health_check.default.self_link]
}

# Health check for the backend service
resource "google_compute_health_check" "default" {
  name               = "default-health-check"
  check_interval_sec = 5
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2

  http_health_check {
    request_path = "/"
    port         = 80
  }
}

# External IP for the load balancer
resource "google_compute_address" "external_ip" {
  name   = "cloud-run-lb-ip"
  region = var.lb_region
}

# Load balancer URL map
resource "google_compute_url_map" "cloud_run_url_map" {
  name            = "cloud-run-url-map"
  default_service = google_compute_backend_service.cloud_run_backend.self_link
}

# HTTP(S) Load Balancer Target Proxy
resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "cloud-run-http-proxy"
  url_map = google_compute_url_map.cloud_run_url_map.id
}

# Global Forwarding Rule for HTTP traffic
resource "google_compute_global_forwarding_rule" "http_rule" {
  name       = "cloud-run-http-rule"
  target     = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
  ip_address = google_compute_address.external_ip.address
}
