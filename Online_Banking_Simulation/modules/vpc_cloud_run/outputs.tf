output "network_id" {
  value = google_compute_network.vpc_network.id
}


output "cloud_run_service_urls" {
  value = [for service in google_cloud_run_service.cloud_run_service : service.status[0].url]
  description = "List of URLs of the deployed Cloud Run services."
}

output "subnet_ids" {
  value = google_compute_subnetwork.subnet[*].id
  description = "List of created subnet IDs."
}

#output "cloud_run_neg" {
 # value = google_compute_global_network_endpoint_group.cloud_run_neg
#}

#output "cloud_run_neg_ids" {
#  value = { for neg in google_compute_global_network_endpoint_group.cloud_run_neg : neg.name => neg.id }
#}
