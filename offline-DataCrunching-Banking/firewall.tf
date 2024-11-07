// Allow HTTP/HTTPS traffic to Cloud Run service (internal users only)
resource "google_compute_firewall" "cloud_run_allow_http_https" {
  name    = "dc-allow-cloud-run-http-https"
  network = google_compute_network.project_2_vpc.self_link
  project = var.project_2_id

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  direction     = "INGRESS"
  source_ranges = ["10.0.0.0/8"] // Allows traffic only from internal network (adjust as needed)
  target_tags   = ["cloud-run"]
}

// Allow traffic between Project 1 and Project 2 (VPC Peering)
resource "google_compute_firewall" "allow_vpc_peering_traffic_project_1" {
  name    = "allow-vpc-peering-traffic-project-1"
  network = google_compute_network.project_1_vpc.self_link
  project = var.project_1_id

  allow {
    protocol = "all"
  }

  direction     = "INGRESS"
  source_ranges = ["10.0.2.0/24"] // CIDR block of Project 2 subnet
  target_tags   = ["vpc-peering"]
}

resource "google_compute_firewall" "allow_vpc_peering_traffic_project_2" {
  name    = "allow-vpc-peering-traffic-project-2"
  network = google_compute_network.project_2_vpc.self_link
  project = var.project_2_id

  allow {
    protocol = "all"
  }

  direction     = "INGRESS"
  source_ranges = ["10.0.1.0/24"] // CIDR block of Project 1 subnet
  target_tags   = ["vpc-peering"]
}
