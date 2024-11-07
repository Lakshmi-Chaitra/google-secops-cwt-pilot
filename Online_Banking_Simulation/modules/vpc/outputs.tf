output "vpc_network_name" {
  value = google_compute_network.vpc_network.name
}

output "subnet_names" {
  value = [for s in google_compute_subnetwork.subnet : s.name]
}

