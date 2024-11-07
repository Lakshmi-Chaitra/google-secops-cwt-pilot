// VPC for Project 1
resource "google_compute_network" "project_1_vpc" {
  name                    = var.project_1_vpc_name
  project                 = var.project_1_id
  auto_create_subnetworks = false
}

// VPC for Project 2
resource "google_compute_network" "project_2_vpc" {
  name                    = var.project_2_vpc_name
  project                 = var.project_2_id
  auto_create_subnetworks = false
}

