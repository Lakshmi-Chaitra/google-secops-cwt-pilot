provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "=6.5.0" # Make sure this is the version you want
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "=2.32.0" # Make sure this is the version you want
    }
  }
}


# VPC Cloud Run
module "vpc_cloud_run" {
  source                 = "./modules/vpc_cloud_run"
  project_id             = var.project_id
  region                 = var.cloud_run_regions[0]
  subnets                = var.subnets_cloud_run
  cloud_run_regions      = var.cloud_run_regions
  cloud_run_service_name = var.cloud_run_service_name
  image_url              = var.image_url
  cloud_run_metadata     = var.cloud_run_metadata
  cloud_run_service_urls = var.cloud_run_service_urls
}

# VPC GKE PD
module "vpc_gke_pd" {
  source         = "./modules/vpc_gke_pd"
  project_id     = var.project_id
  region         = var.gke_pd_regions[0]
  subnets        = var.subnets_gke_pd
  network_name   = var.vpc_gke_pd
  gke_pd_regions = var.gke_pd_regions
  pod_image      = var.pod_image
  pod_replicas   = var.pod_replicas

}

# VPC BT SQL
module "vpc_bt_sql" {
  source         = "./modules/vpc_bt_sql" # path to your module
  project_id     = var.project_id
  vpc_bt_sql     = var.vpc_bt_sql
  subnets_bt_sql = var.subnets_bt_sql
  bt_sql_regions = var.bt_sql_regions
  bt_regions     = var.bt_regions

}

# VPC Peering
module "vpc_peering" {
  source        = "./modules/vpc_peering"
  vpc_cloud_run = module.vpc_cloud_run.network_id
  vpc_gke_pd    = module.vpc_gke_pd.network_id
  vpc_bt_sql    = module.vpc_bt_sql.network_id

}