// VPC Peering from Project 1 to Project 2
resource "google_compute_network_peering" "vpc_peering_from_project_1" {
  name         = var.vpc_peering_name_1_to_2
  network      = google_compute_network.project_1_vpc.self_link
  peer_network = google_compute_network.project_2_vpc.self_link

  depends_on = [google_compute_subnetwork.project_1_subnet, google_compute_subnetwork.project_2_subnet]
}

// VPC Peering from Project 2 to Project 1
resource "google_compute_network_peering" "vpc_peering_from_project_2" {
  name         = var.vpc_peering_name_2_to_1
  network      = google_compute_network.project_2_vpc.self_link
  peer_network = google_compute_network.project_1_vpc.self_link

  depends_on = [google_compute_subnetwork.project_1_subnet, google_compute_subnetwork.project_2_subnet]
}
