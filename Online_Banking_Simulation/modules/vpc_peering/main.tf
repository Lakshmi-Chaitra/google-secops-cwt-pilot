resource "google_compute_network_peering" "vpc_peering_cloud_run_to_gke" {
  name         = "cloud-run-to-gke"
  network      = var.vpc_cloud_run
  peer_network = var.vpc_gke_pd
  lifecycle {
    prevent_destroy = false
  }
}


resource "google_compute_network_peering" "vpc_peering_gke_to_bt_sql" {
  name         = "gke-to-bt-sql"
  network      = var.vpc_gke_pd
  peer_network = var.vpc_bt_sql
  lifecycle {
    prevent_destroy = false
  }
}


