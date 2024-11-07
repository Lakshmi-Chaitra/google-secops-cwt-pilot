# VPC for Cloud Run services
resource "google_compute_network" "vpc_network" {
  name    = "vpc-cloud-run"
  project = var.project_id
}



# Get available zones for each region
data "google_compute_zones" "available" {
  for_each = toset(var.cloud_run_regions)
  region   = each.key
}

# Local variable to select the first zone in each region
locals {
  selected_zones = { for region, zones in data.google_compute_zones.available : region => zones.names[0] }
}


resource "google_compute_region_network_endpoint_group" "cloud_run_neg" {
  name                  = "cloud-run-neg"
  network_endpoint_type = "SERVERLESS"
  region                = "asia-east2"
  cloud_run {
    service = "cloud-run-neg-service"
  }
}


resource "google_cloud_run_service" "cloud_run_neg" {
  name     = "cloud-run-neg"
  location = "asia-east2"

  template {
    spec {
      containers {
        image = var.image_url
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}


# Declare health check resource
resource "google_compute_health_check" "default" {
  name               = "cloud-run-health-check"
  check_interval_sec = 5
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2

  http_health_check {
    request_path = "/"
    port         = 8080
  }

  project = var.project_id
}


resource "google_compute_backend_service" "cloud_run_backend" {
  name                 = "cloud-run-backend"
  protocol             = "HTTP"
  load_balancing_scheme = "EXTERNAL"

  dynamic "backend" {
    for_each = var.neg_list

    content {
      group = backend.value  # The value of each NEG from the neg_list map
    }
  }

  health_checks = [google_compute_health_check.default.self_link]

  project = var.project_id
}
