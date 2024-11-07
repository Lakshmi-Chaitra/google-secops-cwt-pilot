
output "network_id" {
  value = google_compute_network.vpc_network.id
}

output "available_zones" {
  value = data.google_compute_zones.available
}

#output "cwt_ml_namespaces" {
#  value = { for ns_key, ns in kubernetes_namespace.cwt_ml : ns_key => ns.metadata[0].name }  # Correct access of metadata
#}

#output "cwt_ml" {
#  value = kubernetes_namespace.cwt_ml
#}


output "europe_west1_endpoint" {
  value = data.google_container_cluster.europe_west1.endpoint
}

output "asia_southeast1_endpoint" {
  value = data.google_container_cluster.asia_southeast1.endpoint
}

output "asia_east2_endpoint" {
  value = data.google_container_cluster.asia_east2.endpoint
}

output "europe_west2_endpoint" {
  value = data.google_container_cluster.europe_west2.endpoint
}

