resource "google_compute_network" "vpc_network" {
  name    = "vpc-bt-sql"
  project = var.project_id
}

resource "google_compute_subnetwork" "subnet" {
  count         = length(var.subnets_bt_sql)
  name          = var.subnets_bt_sql[count.index].name
  ip_cidr_range = var.subnets_bt_sql[count.index].cidr
  region        = var.subnets_bt_sql[count.index].region
  network       = google_compute_network.vpc_network.id
  project       = var.project_id
}

data "google_compute_zones" "available_zones" {
  for_each = toset(var.bt_sql_regions)
  project  = var.project_id
  region   = each.key
}

resource "google_bigtable_instance" "bt_instance" {
  count   = length(var.bt_regions)
  name    = "cwt-bigtable-instance-${count.index}"
  project = var.project_id

  deletion_protection = false

  cluster {
    cluster_id   = "cwt-bigtable-cluster-${count.index}"
    zone         = element(data.google_compute_zones.available_zones[var.bt_regions[count.index]].names, 0) # Picking the first zone
    num_nodes    = 3
    storage_type = "SSD"
  }
}


resource "google_sql_database_instance" "sql_instance" {
  count            = length(var.bt_sql_regions)
  name             = "cwt-sql-instance-${count.index}"
  database_version = "MYSQL_8_0"
  region           = var.bt_sql_regions[count.index]
  project          = var.project_id

  deletion_protection = false

  settings {
    tier = "db-n1-standard-1"

  }
}

