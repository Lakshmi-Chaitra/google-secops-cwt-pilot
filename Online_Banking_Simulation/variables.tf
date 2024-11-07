variable "project_id" {
  description = "The GCP project ID"
  type        = string
}


variable "region" {
  description = "The GCP region"
  type        = string
}



variable "organization_id" {
  description = "The GCP organization ID"
  type        = string
}

variable "vpc_bt_sql" {
  description = "The name of the VPC for Bigtable/SQL"
  type        = string
}


variable "vpc_cloud_run" {
  description = "The GCP VPC Cloud runname"
  type        = string
}



variable "vpc_gke_pd" {
  description = "The GCP VPC GKE PD name"
  type        = string
}



variable "cloud_run_service_name" {
  description = "The name of the Cloud Run service."
  type        = string
}


variable "cloud_run_regions" {
  description = "List of GCP regions for deploying Cloud Run services"
  type        = list(string)
}


variable "image_url" {
  description = "The container image to deploy."
  type        = string
}

variable "gke_pd_regions" {
  description = "List of GCP regions for deploying Cloud Run services"
  type        = list(string)
}

variable "bt_regions" {
  type        = list(string)
  description = "Regions for Bigtable "
}

variable "bt_sql_regions" {
  description = "List of GCP regions for deploying Cloud Run services"
  type        = list(string)

}

variable "subnets_bt_sql" {
  description = "List of subnet configurations for Big Table and Cloud SQL VPC"
  type = list(object({
    name   = string
    cidr   = string
    region = string
  }))
}


variable "subnets_cloud_run" {
  description = "List of subnet configurations for Cloud Run VPC"
  type = list(object({
    name   = string
    cidr   = string
    region = string
  }))
}

variable "subnets_gke_pd" {
  description = "List of subnet configurations for GKE PD VPC"
  type = list(object({
    name   = string
    cidr   = string
    region = string
  }))
}

variable "subnet_gke_pd_name" {
  type = string
}

variable "cloud_run_metadata" {
  type = object({
    labels      = map(string)
    annotations = map(string)
  })
}


variable "ml_checking_account_service_endpoint" {
  type = string
}

variable "ml_savings_account_service_endpoint" {
  type = string
}

variable "backend_service_name_prefix" {
  type = string
}


variable "cloud_run_service_urls" {
  description = "Map of Cloud Run service URLs per region"
  type        = map(string) # Map with region as key and URL as value
}

variable "pod_replicas" {
  description = "Number of replicas for the NGINX deployment"
  type        = number


}


variable "pod_image" {
  description = "Docker image for the NGINX container"
  type        = string


}

variable "provider_map" {
  type = map(string)
  default = {
    "asia-southeast1" = "asia_southeast1"
    "asia-east2"      = "asia_east2"
    "europe-west2"    = "europe_west2"
    "europe-west1"    = "europe_west1"
  }
}
