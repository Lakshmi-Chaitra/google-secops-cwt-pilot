// Subnet for Project 1
resource "google_compute_subnetwork" "project_1_subnet" {
  name          = "dc-project-1-subnet"
  network       = google_compute_network.project_1_vpc.self_link
  ip_cidr_range = "10.10.1.0/24" // Unique IP range for Project 1
  project       = var.project_1_id
  region        = var.project_1_region
}

// Subnet for Project 2
resource "google_compute_subnetwork" "project_2_subnet" {
  name          = "dc-project-2-subnet"
  network       = google_compute_network.project_2_vpc.self_link
  ip_cidr_range = "10.20.1.0/24" // Unique IP range for Project 2
  project       = var.project_2_id
  region        = var.project_2_region
}
