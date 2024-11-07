variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "subnets" {
  type = list(object({
    name   = string
    cidr   = string
    region = string
  }))
}


variable "network_name" {
  description = "Name of the VPC network"
  type        = string
}


variable "gke_pd_regions" {
  description = "Region for the subnetwork"
  type        = list(string)
}

variable "pod_replicas" {
 description = "Number of replicas for the NGINX deployment"
 type        = number


}


variable "pod_image" {
 description = "Docker image for the NGINX container"
 type        = string


}


variable "cluster_locations" {
  type = list(string)
  default = ["asia-southeast1", "asia-east2", "europe-west2", "europe-west1"]
}

variable "cluster_prefix" {
  type    = string
  default = "gke-cluster"
}


variable "provider_map" {
  type = map(string)
  default = {
    "asia-southeast1"   = "asia_southeast1"
    "asia-east2"        = "asia_east2"
    "europe-west2"      = "europe_west2"
    "europe-west1"      = "europe_west1"
  }
}
