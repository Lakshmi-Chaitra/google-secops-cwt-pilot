variable "project_id" {
  type = string
}

variable "region" {
  type = string
}


variable "subnets" {
  description = "The list of subnet configurations for Cloud Run services"
  type = list(object({
    name    = string
    cidr    = string
    region  = string
  }))
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

variable "cloud_run_metadata" {
  type = object({
    labels      = map(string)
    annotations = map(string)
  })
}

variable "cloud_run_service_urls" {
  description = "Map of Cloud Run service URLs per region"
  type        = map(string)  # Map with region as key and URL as value
}

#variable "neg_list" {
#  description = "List of Network Endpoint Groups for Cloud Run"
#  type        = map(string)
#}
