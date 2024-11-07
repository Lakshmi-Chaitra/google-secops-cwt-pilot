// Route from Project 1 to Project 2
resource "google_compute_route" "route_to_project_2" {
  name             = "route-from-project-1-to-project-2"
  network          = google_compute_network.project_1_vpc.name
  dest_range       = "10.0.2.0/24" // CIDR range of Project 2 subnet
  priority         = 1000
  project          = var.project_1_id // Specify the project ID for Project 1
  next_hop_gateway = "default-internet-gateway"
}

// Route from Project 2 to Project 1
resource "google_compute_route" "route_to_project_1" {
  name             = "route-from-project-2-to-project-1"
  network          = google_compute_network.project_2_vpc.name
  dest_range       = "10.0.1.0/24" // CIDR range of Project 1 subnet
  priority         = 1000
  project          = var.project_2_id // Specify the project ID for Project 2
  next_hop_gateway = "default-internet-gateway"
}
