output "peering_status" {
  value = {
    cloud_run_to_gke = google_compute_network_peering.vpc_peering_cloud_run_to_gke.state
    gke_to_bt_sql = google_compute_network_peering.vpc_peering_gke_to_bt_sql.state
  }
}

