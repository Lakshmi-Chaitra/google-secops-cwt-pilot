# VPC for Cloud Run services
resource "google_compute_network" "vpc_network" {
  name    = "vpc-cloud-run"
  project = var.project_id
}

# Subnets for each region
resource "google_compute_subnetwork" "subnet" {
  count         = length(var.subnets)
  name          = var.subnets[count.index].name
  ip_cidr_range = var.subnets[count.index].cidr
  region        = var.subnets[count.index].region
  network       = google_compute_network.vpc_network.id
  project       = var.project_id

  lifecycle {
    prevent_destroy = false
  }
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

# Cloud Run services in multiple regions
resource "google_cloud_run_service" "cloud_run_service" {
  for_each = toset(var.cloud_run_regions)
  name     = "cloudrun-simulation-${each.key}"
  location = each.key

  template {
    metadata {
      labels      = var.cloud_run_metadata["labels"]
      annotations = var.cloud_run_metadata["annotations"]
    }

    spec {
      containers {
        image = var.image_url

        ports {
          container_port = 8080
        }

        # Define environment variables
        env {
          name  = "ML_CHECKING_ACCOUNT_SERVICE_ENDPOINT"
          value = "us-central1-docker.pkg.dev/ctp-prj-1/cloud-run-source-deploy/online-banking-ml"
        }

        env {
          name  = "ML_SAVINGS_ACCOUNT_SERVICE_ENDPOINT"
          value = "us-central1-docker.pkg.dev/ctp-prj-1/cloud-run-source-deploy/online-banking-ml"
        }

        env {
          name  = "SERVICE_PORT"
          value = "8080"
        }

        resources {
          limits = {
            memory = "512Mi"
            cpu    = "1"
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

