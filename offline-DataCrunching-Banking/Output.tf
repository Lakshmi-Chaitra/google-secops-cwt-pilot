// Output the name of the Bigtable instance created
#output "bigtable_instance_name" {
#  description = "The name of the Bigtable instance created."
#  value       = google_bigtable_instance.bigtable_instance.name
#}

// Output the URL for the deployed Cloud Run service
output "cloud_run_url" {
  description = "The URL for the deployed Cloud Run service."
  value       = google_cloud_run_service.cloud_run.status[0].url
}

// Output the status of VPC peering from Project 1 to Project 2
output "vpc_peering_status_project_1_to_2" {
  description = "The status of the VPC peering connection from Project 1 to Project 2."
  value       = google_compute_network_peering.vpc_peering_from_project_1.state
}

// Output the name of the VPC peering connection from Project 1 to Project 2
output "vpc_peering_name_project_1_to_2" {
  description = "The name of the VPC peering connection from Project 1 to Project 2."
  value       = google_compute_network_peering.vpc_peering_from_project_1.name
}

// Output the status of VPC peering from Project 2 to Project 1
output "vpc_peering_status_project_2_to_1" {
  description = "The status of the VPC peering connection from Project 2 to Project 1."
  value       = google_compute_network_peering.vpc_peering_from_project_2.state
}

// Output the name of the VPC peering connection from Project 2 to Project 1
output "vpc_peering_name_project_2_to_1" {
  description = "The name of the VPC peering connection from Project 2 to Project 1."
  value       = google_compute_network_peering.vpc_peering_from_project_2.name
}
