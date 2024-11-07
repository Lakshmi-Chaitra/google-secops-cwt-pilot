provider "google" {
  project = var.project_id
  region  = var.region
}


# Create VPC Network
resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  count        = length(var.subnets)
  name         = var.subnets[count.index].name
 # ip_cidr_range = var.subnets[count.index].cidr_block
  ip_cidr_range  = element(["10.0.14.0/24", "10.0.15.0/24", "10.0.16.0/24"], count.index)
  region       = var.subnets[count.index].region
  network      = google_compute_network.vpc_network.name
  lifecycle {
    prevent_destroy = false 
  }
}



resource "google_compute_firewall" "allow_internal" {
  name    = "ctp-pilot-allow-internal"
  network = google_compute_network.vpc_network.name
  

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.0.0.0/8"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "ctp-pilot-allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
