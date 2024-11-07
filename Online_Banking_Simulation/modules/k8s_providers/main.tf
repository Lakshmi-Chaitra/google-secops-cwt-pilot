

provider "kubernetes" {
  alias                  = "asia_southeast1"
  host                   = "https://${var.gke_clusters["asia-southeast1"].endpoint}"
  token                  = var.gke_clusters["asia-southeast1"].master_auth_token
  cluster_ca_certificate = base64decode(var.gke_clusters["asia-southeast1"].ca_certificate)
}

provider "kubernetes" {
  alias                  = "asia_east2"
  host                   = "https://${var.gke_clusters["asia-east2"].endpoint}"
  token                  = var.gke_clusters["asia-east2"].master_auth_token
  cluster_ca_certificate = base64decode(var.gke_clusters["asia-east2"].ca_certificate)
}

provider "kubernetes" {
  alias                  = "europe_west2"
  host                   = "https://${var.gke_clusters["europe-west2"].endpoint}"
  token                  = var.gke_clusters["europe-west2"].master_auth_token
  cluster_ca_certificate = base64decode(var.gke_clusters["europe-west2"].ca_certificate)
}

provider "kubernetes" {
  alias                  = "europe_west1"
  host                   = "https://${var.gke_clusters["europe-west1"].endpoint}"
  token                  = var.gke_clusters["europe-west1"].master_auth_token
  cluster_ca_certificate = base64decode(var.gke_clusters["europe-west1"].ca_certificate)
}


